Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk ([2001:4d48:ad52:32c8:5054:ff:fe00:142])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVuEM-0069LP-1A
 for kexec@lists.infradead.org; Mon, 12 Apr 2021 10:55:47 +0000
Date: Mon, 12 Apr 2021 11:52:35 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/1] arm: do not copy magic 4 bytes of appended DTB in
 zImage
Message-ID: <20210412105235.GK1463@shell.armlinux.org.uk>
References: <20210408200644.19724-1-egorenar-dev@posteo.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408200644.19724-1-egorenar-dev@posteo.net>
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
To: Alexander Egorenkov <egorenar-dev@posteo.net>
Cc: kexec@lists.infradead.org

On Thu, Apr 08, 2021 at 10:06:44PM +0200, Alexander Egorenkov wrote:
> If the passed zImage happens to have a DTB appended, then the magic 4 bytes
> of the DTB are copied together with the kernel image. This leads to
> failed kexec boots because the decompressor finds the aforementioned
> DTB magic and falsely tries to replace the DTB passed in the register r2
> with the non-existent appended one.
> 
> Signed-off-by: Alexander Egorenkov <egorenar-dev@posteo.net>

This looks correct, but I would like a comment before the assignment
of kernel_buf_size to explain that this is the size of the compressed
kernel image excluding any appended DTB.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
