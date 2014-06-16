Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wwafk-0007tH-Kj
 for kexec@lists.infradead.org; Mon, 16 Jun 2014 17:26:21 +0000
Date: Mon, 16 Jun 2014 13:25:38 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 09/13] purgatory: Core purgatory functionality
Message-ID: <20140616172538.GB4515@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-10-git-send-email-vgoyal@redhat.com>
 <20140605200523.GB26110@pd.tnic> <20140606195104.GM1526@redhat.com>
 <20140613101713.GD4751@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140613101713.GD4751@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Fri, Jun 13, 2014 at 12:17:13PM +0200, Borislav Petkov wrote:
> On Fri, Jun 06, 2014 at 03:51:04PM -0400, Vivek Goyal wrote:
> > On Thu, Jun 05, 2014 at 10:05:23PM +0200, Borislav Petkov wrote:
> > 
> > [..]
> > > > @@ -249,6 +254,7 @@ archclean:
> > > >  	$(Q)rm -rf $(objtree)/arch/x86_64
> > > >  	$(Q)$(MAKE) $(clean)=$(boot)
> > > >  	$(Q)$(MAKE) $(clean)=arch/x86/tools
> > > 
> > > ifeq ($(CONFIG_KEXEC),y)
> > > 	$(Q)$(MAKE) $(clean)=arch/x86/purgatory
> > > endif
> > 
> > Hmm.., is it strictly required? I am wondering what happens if I build
> > a kernel with CONFIG_KEXEC=y, then set CONFIG_KEXEC=n and do "make clean".
> 
> Try it - it works here.
> 
> > I think I will still like any files in arch/x86/purgatory to be cleaned
> > despite the fact that CONFIG_KEXEC=n. Isn't it?
> 
> Yep, that works. Conversely, we don't want people who haven't enabled
> KEXEC ever to have unrelated cleanup delay.
> 

I tried following with CONFIG_KEXEC=n

ifeq ($(CONFIG_KEXEC),y)
        $(Q)$(MAKE) $(clean)=arch/x86/purgatory
endif

And still "make V=1 clean" shows me that it is going in purgatory dir
to clean things up.

make -f scripts/Makefile.clean obj=arch/x86/purgatory

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
