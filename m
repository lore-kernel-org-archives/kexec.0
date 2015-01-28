Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.scotdoyle.com ([2602:ffea:1:10d::1])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YGZyG-0005BI-IS
 for kexec@lists.infradead.org; Wed, 28 Jan 2015 21:16:21 +0000
Date: Wed, 28 Jan 2015 21:14:03 +0000 (UTC)
From: Scot Doyle <lkml14@scotdoyle.com>
Subject: Re: Edited kexec_load(2) [kexec_file_load()] man page for review
In-Reply-To: <20150128203402.GG15342@redhat.com>
Message-ID: <alpine.DEB.2.11.1501282104490.9275@localhost.localdomain>
References: <545FBDDD.9060801@gmail.com> <20141111213037.GA31445@redhat.com>
 <54ADA284.30502@gmail.com> <20150112221634.GD16162@redhat.com>
 <54B91271.3000600@gmail.com> <20150127142459.GA12851@redhat.com>
 <54C89816.8030709@gmail.com> <20150128144803.GC15342@redhat.com>
 <CAKgNAkhhVq5fuqwH0aPdgR1bKkAPPPuS84hfAFg3grGEJNxS4w@mail.gmail.com>
 <20150128203402.GG15342@redhat.com>
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
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Andi Kleen <andi@firstfloor.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>

On Wed, 28 Jan 2015, Vivek Goyal wrote:
> On Wed, Jan 28, 2015 at 04:49:34PM +0100, Michael Kerrisk (man-pages) wrote:
> > Hello Vivek,
> > 
> > >> I've made various adjustments to the page in the light of your comments
> > >> above. Thanks!
> > >
> > > Thank you for following it up and improving kexec man page.
> > 
> > You're welcome. So, by now, I've made quite a lot of changes
> > (including adding a number of cases under ERRORS). I think the revised
> > kexec_load/kexec_file_load page is pretty much ready to go, but would
> > you be willing to give the text below a check over first?
> > 
> 
> Hi Michael,
> 
> I had a quick look and it looks good to me.
> 
> Thanks
> Vivek

When I tested, kexec_file_load required CONFIG_RELOCATABLE. Is the same 
true for kexec_load? Would it make sense to note this in the man pages 
along with the need for CONFIG_KEXEC_FILE, etc? Or as an error message?

Thanks,
Scot


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
