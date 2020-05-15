Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 15 May 2020 22:06:11 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: kexec: arm: possible overwrite of initrd
Message-ID: <20200515210611.GS1551@shell.armlinux.org.uk>
References: <20200515135712.GA5979@Red>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200515135712.GA5979@Red>
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
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:57:12PM +0200, Corentin Labbe wrote:
> Hello
> 
> Following https://lkml.org/lkml/2020/4/6/96 I was able to boot my Cubieboard4 via kexec reliabily.

You can try increasing the kernel size that kexec thinks the kernel
needs, but it should be extremely accurate with modern kexec.

--image-size $((0x01dc8154 + 0x10000))

will add 64k on top of what you currently have.  Note where the first
figure comes from (you'll find it in the debug output, see
"Resulting kernel space").

The best I can say is try playing around with that - but, kexec's
calculations should be spot on to stop the booting kernel from
overwriting the initrd.

The only way to debug that is to get the booted kernel to hexdump the
initrd so it's possible to see what happened to it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
