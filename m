Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SWABC-0006DK-Ua
 for kexec@lists.infradead.org; Sun, 20 May 2012 17:44:32 +0000
Message-ID: <4FB92D5A.3060507@redhat.com>
Date: Sun, 20 May 2012 20:43:54 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] Export offsets of VMCS fields as note information
 for kdump
References: <4FB35C48.30708@cn.fujitsu.com>
In-Reply-To: <4FB35C48.30708@cn.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: zhangyanfei <zhangyanfei@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com, Greg KH <gregkh@linuxfoundation.org>

On 05/16/2012 10:50 AM, zhangyanfei wrote:
> This patch set exports offsets of VMCS fields as note information for
> kdump. We call it VMCSINFO. The purpose of VMCSINFO is to retrieve
> runtime state of guest machine image, such as registers, in host
> machine's crash dump as VMCS format. The problem is that VMCS internal
> is hidden by Intel in its specification. So, we slove this problem
> by reverse engineering implemented in this patch set. The VMCSINFO
> is exported via sysfs to kexec-tools just like VMCOREINFO.
>
> Here are two usercases for two features that we want.
>
> 1) Create guest machine's crash dumpfile from host machine's crash dumpfile
>
> In general, we want to use this feature on failure analysis for the system
> where the processing depends on the communication between host and guest
> machines to look into the system from both machines's viewpoints.
>
> As a concrete situation, consider where there's heartbeat monitoring
> feature on the guest machine's side, where we need to determine in
> which machine side the cause of heartbeat stop lies. In our actual
> experiments, we encountered such situation and we found the cause of
> the bug was in host's process schedular so guest machine's vcpu stopped
> for a long time and then led to heartbeat stop.
>
> The module that judges heartbeat stop is on guest machine, so we need
> to debug guest machine's data. But if the cause lies in host machine
> side, we need to look into host machine's crash dump.

Do you mean, that a heartbeat failure in the guest lead to host panic?

My expectation is that a problem in the guest will cause the guest to
panic and perhaps produce a dump; the host will remain up.

> Without this feature, we first create guest machine's dump and then
> create host mahine's, but there's only a short time between two
> processings, during which it's unlikely that buggy situation remains.
>
> So, we think the feature is useful to debug both guest machine's and
> host machine's sides at the same time, and expect we can make failure
> analysis efficiently.
>
> Of course, we believe this feature is commonly useful on the situation
> where guest machine doesn't work well due to something of host machine's.
>
> 2) Get offsets of VMCS information on the CPU running on the host machine
>
> If kdump doesn't work well, then it means we cannot use kvm API to get
> register values of guest machine and they are still left on its vmcs
> region. In the case, we use crash dump mechanism running outside of
> linux kernel, such as sadump, a firmware-based crash dump. Then VMCS
> information is then necessary.

Shouldn't sadump then expose the VMCS offsets? Perhaps bundling them
into its dump file?


-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
