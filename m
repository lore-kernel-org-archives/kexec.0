Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1eQgn4-0002E4-KY
 for kexec@lists.infradead.org; Sun, 17 Dec 2017 21:48:13 +0000
Date: Sun, 17 Dec 2017 22:47:35 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171217214735.nuxq5zo2eknqpbpi@pd.tnic>
References: <20171216001514.x5eg37ad4aa2fwqt@dwarf.suse.cz>
 <20171216010142.GK12442@x1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171216010142.GK12442@x1>
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
To: Baoquan He <bhe@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>, Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, yinghai@kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Sat, Dec 16, 2017 at 09:01:42AM +0800, Baoquan He wrote:
> 2) If firmware is broken, you can't enable gart in firmware, will
> firmware engineer fix this since it's a firmware bug?

Slow down and get a reality check first please!

A firmware engineer will fix a 10yr old BIOS?!? Yeah right. And I'll get
a pink pony for Christmas. Geez.

We need a reliable way to tell the second kernel not to access the gart
range. And frankly, the best thing to do would be to teach the *second*
kernel to simply avoid the gart range. Regardless of what it gets told
by the ELF header. Because there are some ranges which it shouldn't
touch. Maybe we can reuse the gart detection code to do that in the
second kernel too.

But I haven't looked at it, might be hairy. Need to deal with this PTI
madness first.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
