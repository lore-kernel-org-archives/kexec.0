Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDGIh-0008OD-O5
 for kexec@lists.infradead.org; Wed, 15 Jun 2016 19:16:33 +0000
Date: Wed, 15 Jun 2016 20:13:52 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: kexec failures with DEBUG_RODATA
Message-ID: <20160615191352.GG1041@n2100.armlinux.org.uk>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <20160615075508.GB21202@dhcppc6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160615075508.GB21202@dhcppc6>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@google.com>

On Wed, Jun 15, 2016 at 01:25:08PM +0530, Pratyush Anand wrote:
> Sure, having a header information would be handy to do it. Other alternative
> could be that we define "HAVE_LIBZ" and then we can have something like
> kexec-Image-arm.c which handles plane Image.  We can also have something like
> get_zlib_decompressed_length() which can give us exact length we need for kernel
> and then we can place initrd accordingly in zImage_arm_load().

I really don't want to do that.  There are things that the decompressor
does which make it easier to deal with the zImage than the Image.

> I see at least another issue clearly in ARM kernel code with CONFIG_DEBUG_RODATA
> enabled.  When CONFIG_DEBUG_RODATA is enabled, we can not write text area.
> kexec_start_address has been defined in relocate_kernel.S as a text area.
> machine_kexec() writes at kexec_start_address with image->start. Similarly there
> would be issues for overwriting of kexec_indirection_page, kexec_mach_type and
> kexec_boot_atags. If arm mmu mapping configures text pages as RO, then we should
> see an abort as soon as we do these writes.

That's not a problem, because set_kernel_text_rw() is called immediately
prior to writing, which has the effect of allowing these writes.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
