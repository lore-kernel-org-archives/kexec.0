Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SKpar-0006Um-Uw
 for kexec@lists.infradead.org; Thu, 19 Apr 2012 11:32:11 +0000
Message-ID: <4F8FF7AC.1060309@redhat.com>
Date: Thu, 19 Apr 2012 14:31:56 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
References: <4F8EABF7.805@redhat.com>
 <20120419.193640.59653378.d.hatayama@jp.fujitsu.com>
 <4F8FEC22.400@redhat.com>
 <20120419.202707.276752866.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120419.202707.276752866.d.hatayama@jp.fujitsu.com>
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

On 04/19/2012 02:27 PM, HATAYAMA Daisuke wrote:
> >> The reason why we want to retrieve guest machine's memory image as
> >> crash dump is that then we can debug guest machine's status using
> >> symbolic debugger such as gdb and crash utility.
> >>
> >> This is very useful. Please consider the situation where engineers are
> >> forced to look into guest machine's memory image through qemu-kvm's
> >> process core dump using gdb without any symbolic information. It's
> >> very inefficient.
> > 
> > I still don't follow.  If qemu crashed, the values in guest registers
> > are irrelevant.  In what way can the help debug the qemu crash?
> > 
>
> It would be not helpful for the qemu crash case you are concerned
> about. We want to use the guest state data to look into guest
> machine's image in the crasshed qemu.

Why?

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
