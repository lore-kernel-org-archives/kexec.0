Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SKq9k-0000iL-Jo
 for kexec@lists.infradead.org; Thu, 19 Apr 2012 12:08:14 +0000
Message-ID: <4F900020.5010702@redhat.com>
Date: Thu, 19 Apr 2012 15:08:00 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
References: <4F8FEC22.400@redhat.com>
 <20120419.202707.276752866.d.hatayama@jp.fujitsu.com>
 <4F8FF7AC.1060309@redhat.com>
 <20120419.210119.246504497.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120419.210119.246504497.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, zhangyanfei@cn.fujitsu.com, ebiederm@xmission.com, ludwig.nussel@suse.de

On 04/19/2012 03:01 PM, HATAYAMA Daisuke wrote:
> >> It would be not helpful for the qemu crash case you are concerned
> >> about. We want to use the guest state data to look into guest
> >> machine's image in the crasshed qemu.
> > 
> > Why?
> > 
>
> It seems natural to check the situation from guest machine's side when
> qemu crashs. Suppose a service is running on the guest machine, and
> then the qemu crash. Then, we may need to know the details of the
> progress of the service if it's important. What has been successfully
> done, and what has not yet.

How can a service on the guest be related to a qemu crash?  And how
would guest registers help?

You can extract the list of running processes from a qemu crash dump
without looking at guest registers.  And most vcpus are running
asynchronously to qemu, so their register contents is irrelevant (if a
vcpu is running synchronously with qemu - it just exited to qemu and is
waiting for a response - then you'd see the details in qemu's call stack).

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
