Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wv4GB-0006iS-Jw
 for kexec@lists.infradead.org; Thu, 12 Jun 2014 12:37:40 +0000
Date: Thu, 12 Jun 2014 08:36:58 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 00/13][V3] kexec: A new system call to allow in
 kernel loading
Message-ID: <20140612123658.GD9578@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <20140612054203.GA3696@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140612054203.GA3696@darkstar.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, chaowang@redhat.com

On Thu, Jun 12, 2014 at 01:42:03PM +0800, Dave Young wrote:
> On 06/03/14 at 09:06am, Vivek Goyal wrote:
> > Hi,
> > 
> > This is V3 of the patchset. Previous versions were posted here.
> > 
> > V1: https://lkml.org/lkml/2013/11/20/540
> > V2: https://lkml.org/lkml/2014/1/27/331
> > 
> > Changes since v2:
> > 
> > - Took care of most of the review comments from V2.
> > - Added support for kexec/kdump on EFI systems.
> > - Dropped support for loading ELF vmlinux.
> > 
> > This patch series is generated on top of 3.15.0-rc8. It also requires a
> > two patch cleanup series which is sitting in -tip tree here.
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=x86/boot
> > 
> > This patch series does not do kernel signature verification yet. I plan
> > to post another patch series for that. Now bzImage is already signed
> > with PKCS7 signature I plan to parse and verify those signatures.
> > 
> > Primary goal of this patchset is to prepare groundwork so that kernel
> > image can be signed and signatures be verified during kexec load. This
> > should help with two things.
> > 
> > - It should allow kexec/kdump on secureboot enabled machines.
> > 
> > - In general it can help even without secureboot. By being able to verify
> >   kernel image signature in kexec, it should help with avoiding module
> >   signing restrictions. Matthew Garret showed how to boot into a custom
> >   kernel, modify first kernel's memory and then jump back to old kernel and
> >   bypass any policy one wants to.
> > 
> > Any feedback is welcome.
> 
> Hi, Vivek
> 
> For efi ioremapping case, in 3.15 kernel efi runtime maps will not be saved
> if efi=old_map is used. So you need detect this and fail the kexec file load.
> 
> Otherwise the patchset works for me.

Thanks Dave. I will make sure that in case of old mapping, kexec loading
fails. I don't want to be supporting that old "noefi" mode in this new
system call. Even SGI is planning to fix their firmware to support
1:1 mapping. 

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
