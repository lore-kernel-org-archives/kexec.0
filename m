Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vyfdf-0000JN-Vz
 for kexec@lists.infradead.org; Thu, 02 Jan 2014 10:36:32 +0000
Date: Thu, 2 Jan 2014 10:35:49 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v7 00/12] kexec kernel efi runtime support
Message-ID: <20140102103549.GC2618@console-pimps.org>
References: <1387533742-18018-1-git-send-email-dyoung@redhat.com>
 <20131221173515.GE29501@console-pimps.org>
 <20140102024256.GB2563@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140102024256.GB2563@darkstar.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, msalter@redhat.com, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, leif.lindholm@linaro.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, mingo@kernel.org, vgoyal@redhat.com

On Thu, 02 Jan, at 10:42:56AM, Dave Young wrote:
> 
> Hi, Matt
> 
> randconfig build robot reports several problems:
> 1. sparse warnings which should be fixed by the early_memremap patches

Yeah, this will be fixed up when Mark's memremap patch series gets
merged.

> Here is the fix for 2. and 3, please take a look. I'm not sure if I
> should resend the patches or leave them to you.
 
Please send these as separate patches and include the compiler errors in
the commit message. I'll pick them up and send them to Peter.
 
> build fix: move parse_efi_setup to efi*.c, call it in efi_init instead in setup.c

Why have you moved the call site for parse_efi_setup()? What's the
rationale? Parsing SETUP_* entries outside of parse_setup_data() seems
to me to be a step backwards in terms of clarity.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
