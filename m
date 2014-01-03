Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vyw8j-00074r-Q2
 for kexec@lists.infradead.org; Fri, 03 Jan 2014 04:13:42 +0000
Date: Fri, 3 Jan 2014 12:12:37 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v7 00/12] kexec kernel efi runtime support
Message-ID: <20140103041237.GA4506@dhcp-16-198.nay.redhat.com>
References: <1387533742-18018-1-git-send-email-dyoung@redhat.com>
 <20131221173515.GE29501@console-pimps.org>
 <20140102024256.GB2563@darkstar.nay.redhat.com>
 <20140102103549.GC2618@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140102103549.GC2618@console-pimps.org>
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
To: Matt Fleming <matt@console-pimps.org>
Cc: mjg59@srcf.ucam.org, msalter@redhat.com, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, leif.lindholm@linaro.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, mingo@kernel.org, vgoyal@redhat.com

> Please send these as separate patches and include the compiler errors in
> the commit message. I'll pick them up and send them to Peter.

Sent.

>  
> > build fix: move parse_efi_setup to efi*.c, call it in efi_init instead in setup.c
> 
> Why have you moved the call site for parse_efi_setup()? What's the
> rationale? Parsing SETUP_* entries outside of parse_setup_data() seems
> to me to be a step backwards in terms of clarity.

SETUP_PCI also duplicate the parsing logic out of setup.c.
I added static inline in ifdef else branch, but I got some warnings yestoday
about "unused function", double checked it today there's no such warnings
anymore, it might be caused by some mistake.

Changed to static inline {} in patches I just sent a moment ago.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
