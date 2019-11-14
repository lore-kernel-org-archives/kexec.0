Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iVGLq-0008If-Q9
 for kexec@lists.infradead.org; Thu, 14 Nov 2019 14:44:04 +0000
Date: Thu, 14 Nov 2019 15:43:53 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3 v9] kexec: Fix i386 build warnings that missed
 declaration of struct kimage
Message-ID: <20191114144353.GB7222@zn.tnic>
References: <20191108090027.11082-1-lijiang@redhat.com>
 <20191108090027.11082-4-lijiang@redhat.com>
 <20191114123920.GA7222@zn.tnic>
 <59fbd119-495a-4d00-9738-98c22b276c1f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <59fbd119-495a-4d00-9738-98c22b276c1f@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, bhe@redhat.com, horms@verge.net.au, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, d.hatayama@fujitsu.com, vgoyal@redhat.com

On Thu, Nov 14, 2019 at 10:20:42PM +0800, lijiang wrote:
> I really saw my building result, but kbuild reported the following messages:
> 
> vim +5 arch/x86/include/asm/crash.h
> 
> dd5f726076cc76 Vivek Goyal 2014-08-08   4  
> dd5f726076cc76 Vivek Goyal 2014-08-08  @5  int crash_load_segments(struct kimage *image);
> dd5f726076cc76 Vivek Goyal 2014-08-08   6  int crash_copy_backup_region(struct kimage *image);
> dd5f726076cc76 Vivek Goyal 2014-08-08   7  int crash_setup_memmap_entries(struct kimage *image,
> dd5f726076cc76 Vivek Goyal 2014-08-08   8  		struct boot_params *params);
> 89f579ce99f7e0 Yi Wang     2018-11-22   9  void crash_smp_send_stop(void);
> dd5f726076cc76 Vivek Goyal 2014-08-08  10  
> 
> :::::: The code at line 5 was first introduced by commit 
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> :::::: dd5f726076cc7639d9713b334c8c133f77c6757a kexec: support for kexec on panic using new system call
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You should not take the report of a bot blindly but should always double
check it. Like every other computer system programmed by humans, it can
make mistakes.

> Would you mind giving me any suggestions about this?

I'll take care of it all and push the results out soon.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
