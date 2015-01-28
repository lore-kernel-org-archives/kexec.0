Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.scotdoyle.com ([23.226.141.211])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YGarG-0005gz-Vo
 for kexec@lists.infradead.org; Wed, 28 Jan 2015 22:13:11 +0000
Date: Wed, 28 Jan 2015 22:10:59 +0000 (UTC)
From: Scot Doyle <lkml14@scotdoyle.com>
Subject: Re: Edited kexec_load(2) [kexec_file_load()] man page for review
In-Reply-To: <20150128213125.GH15342@redhat.com>
Message-ID: <alpine.DEB.2.11.1501282207570.5656@localhost.localdomain>
References: <20141111213037.GA31445@redhat.com> <54ADA284.30502@gmail.com>
 <20150112221634.GD16162@redhat.com> <54B91271.3000600@gmail.com>
 <20150127142459.GA12851@redhat.com> <54C89816.8030709@gmail.com>
 <20150128144803.GC15342@redhat.com>
 <CAKgNAkhhVq5fuqwH0aPdgR1bKkAPPPuS84hfAFg3grGEJNxS4w@mail.gmail.com>
 <20150128203402.GG15342@redhat.com>
 <alpine.DEB.2.11.1501282104490.9275@localhost.localdomain>
 <20150128213125.GH15342@redhat.com>
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Andi Kleen <andi@firstfloor.org>, Borislav Petkov <bp@alien8.de>, "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed, 28 Jan 2015, Vivek Goyal wrote:
> On Wed, Jan 28, 2015 at 09:14:03PM +0000, Scot Doyle wrote:
> > On Wed, 28 Jan 2015, Vivek Goyal wrote:
> > > On Wed, Jan 28, 2015 at 04:49:34PM +0100, Michael Kerrisk (man-pages) wrote:
> > > > Hello Vivek,
> > > > 
> > > > >> I've made various adjustments to the page in the light of your comments
> > > > >> above. Thanks!
> > > > >
> > > > > Thank you for following it up and improving kexec man page.
> > > > 
> > > > You're welcome. So, by now, I've made quite a lot of changes
> > > > (including adding a number of cases under ERRORS). I think the revised
> > > > kexec_load/kexec_file_load page is pretty much ready to go, but would
> > > > you be willing to give the text below a check over first?
> > > > 
> > > 
> > > Hi Michael,
> > > 
> > > I had a quick look and it looks good to me.
> > > 
> > > Thanks
> > > Vivek
> > 
> > When I tested, kexec_file_load required CONFIG_RELOCATABLE. Is the same 
> > true for kexec_load? Would it make sense to note this in the man pages 
> > along with the need for CONFIG_KEXEC_FILE, etc? Or as an error message?
> 
> Hmm.., I can't see an explicity dependency between RELOCATABLE and
> KEXEC. Both KEXEC and KEXEC_FILE should be able to load a kernel
> even if it had RELOCATABLE=n.
> 
> Just that kernel will run from the address it has been built for.
> 
> Thanks
> Vivek

Confusing, right? kexec_file_load returns -ENOEXEC and dmesg says 
"kexec-bzImage64: XLF_CAN_BE_LOADED_ABOVE_4G is not set." which leads to
arch/x86/boot/header.S line 396:

#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_X86_64)  
   /* kernel/boot_param/ramdisk could be loaded above 4g */
# define XLF1 XLF_CAN_BE_LOADED_ABOVE_4G
#else
# define XLF1 0
#endif


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
