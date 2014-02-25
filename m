Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WINn9-0005EW-9p
 for kexec@lists.infradead.org; Tue, 25 Feb 2014 19:35:48 +0000
Date: Tue, 25 Feb 2014 20:35:19 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 06/11] kexec: A new system call, kexec_file_load, for in
 kernel kexec
Message-ID: <20140225203519.77abfa8d@hananiah.suse.cz>
In-Reply-To: <20140224164131.GJ4631@redhat.com>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-7-git-send-email-vgoyal@redhat.com>
 <20140221145910.GE11531@pd.tnic> <20140224164131.GJ4631@redhat.com>
Mime-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: mjg59@srcf.ucam.org, greg@kroah.com, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, ebiederm@xmission.com, jkosina@suse.cz

On Mon, 24 Feb 2014 11:41:31 -0500
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, Feb 21, 2014 at 03:59:10PM +0100, Borislav Petkov wrote:
> 
>[...]
> > 
> > ...
> > 
> > > diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> > > index d6629d4..5fddb1b 100644
> > > --- a/include/uapi/linux/kexec.h
> > > +++ b/include/uapi/linux/kexec.h
> > > @@ -13,6 +13,10 @@
> > >  #define KEXEC_PRESERVE_CONTEXT	0x00000002
> > >  #define KEXEC_ARCH_MASK		0xffff0000
> > >  
> > > +/* Kexec file load interface flags */
> > > +#define KEXEC_FILE_UNLOAD	0x00000001
> > > +#define KEXEC_FILE_ON_CRASH	0x00000002
> > 
> > BIT()
> 
> What's that?

#define BIT(nr)                 (1UL << (nr))

For my part I'm not convinced it's a better way to do it, unless
Borislav also wanted to suggest adding an enum for the bit number
values...

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
