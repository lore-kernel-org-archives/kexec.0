Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WrsHn-0004H5-8P
 for kexec@lists.infradead.org; Tue, 03 Jun 2014 17:14:07 +0000
Date: Tue, 3 Jun 2014 13:13:27 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 01/13] bin2c: Move bin2c in scripts/basic
Message-ID: <20140603171327.GJ23395@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-2-git-send-email-vgoyal@redhat.com>
 <20140603160126.GB18806@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140603160126.GB18806@pd.tnic>
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

On Tue, Jun 03, 2014 at 06:01:26PM +0200, Borislav Petkov wrote:
> On Tue, Jun 03, 2014 at 09:06:50AM -0400, Vivek Goyal wrote:
> > Kexec wants to use bin2c and it wants to use it really early in the build
> > process. See arch/x86/purgatory/ code in later patches.
> > 
> > So move bin2c in scripts/basic so that it can be built very early and
> > be usable by arch/x86/purgatory/
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  kernel/Makefile        |  2 +-
> >  scripts/Makefile       |  1 -
> >  scripts/basic/Makefile |  1 +
> >  scripts/basic/bin2c.c  | 35 +++++++++++++++++++++++++++++++++++
> >  scripts/bin2c.c        | 36 ------------------------------------
> >  5 files changed, 37 insertions(+), 38 deletions(-)
> >  create mode 100644 scripts/basic/bin2c.c
> >  delete mode 100644 scripts/bin2c.c
> > 
> > diff --git a/kernel/Makefile b/kernel/Makefile
> > index f2a8b62..9b07bb7 100644
> > --- a/kernel/Makefile
> > +++ b/kernel/Makefile
> > @@ -105,7 +105,7 @@ targets += config_data.gz
> >  $(obj)/config_data.gz: $(KCONFIG_CONFIG) FORCE
> >  	$(call if_changed,gzip)
> >  
> > -      filechk_ikconfiggz = (echo "static const char kernel_config_data[] __used = MAGIC_START"; cat $< | scripts/bin2c; echo "MAGIC_END;")
> > +      filechk_ikconfiggz = (echo "static const char kernel_config_data[] __used = MAGIC_START"; cat $< | scripts/basic/bin2c; echo "MAGIC_END;")
> >  targets += config_data.h
> >  $(obj)/config_data.h: $(obj)/config_data.gz FORCE
> >  	$(call filechk,ikconfiggz)
> > diff --git a/scripts/Makefile b/scripts/Makefile
> > index 1d07860..e9d56fb 100644
> > --- a/scripts/Makefile
> > +++ b/scripts/Makefile
> > @@ -13,7 +13,6 @@ HOST_EXTRACFLAGS += -I$(srctree)/tools/include
> >  hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
> >  hostprogs-$(CONFIG_LOGO)         += pnmtologo
> >  hostprogs-$(CONFIG_VT)           += conmakehash
> > -hostprogs-$(CONFIG_IKCONFIG)     += bin2c
> 
> You also'd need to move the "bin2c" entry from scripts/.gitignore to
> scripts/basic/.gitignore. I just noticed this by grepping around the
> sources.

Good catch. Will do in next version.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
