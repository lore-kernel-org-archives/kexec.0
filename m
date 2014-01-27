Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W7taH-0002Q4-Qi
 for kexec@lists.infradead.org; Mon, 27 Jan 2014 21:19:10 +0000
Date: Mon, 27 Jan 2014 16:18:45 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 03/11] bin2c: Move bin2c in scripts/basic
Message-ID: <20140127211845.GD22256@redhat.com>
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-4-git-send-email-vgoyal@redhat.com>
 <52E6CBAA.1080405@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52E6CBAA.1080405@suse.cz>
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
To: Michal Marek <mmarek@suse.cz>
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com

On Mon, Jan 27, 2014 at 10:12:10PM +0100, Michal Marek wrote:
> Dne 27.1.2014 19:57, Vivek Goyal napsal(a):
> > Kexec wants to use bin2c and it wants to use it really early in the build
> > process. See arch/x86/purgatory/ code in later patches.
> > 
> > So move bin2c in scripts/basic so that it can be built very early and
> > be usable by arch/x86/purgatory/
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> [...]
> > diff --git a/scripts/basic/Makefile b/scripts/basic/Makefile
> > index 4fcef87..afbc1cd 100644
> > --- a/scripts/basic/Makefile
> > +++ b/scripts/basic/Makefile
> > @@ -9,6 +9,7 @@
> >  # fixdep: 	 Used to generate dependency information during build process
> >  
> >  hostprogs-y	:= fixdep
> > +hostprogs-$(CONFIG_IKCONFIG)     += bin2c
> 
> Is the CONFIG_IKCONFIG dependency still correct, now that you found
> another use of bin2c?

In the next patch I changed depedency too. (CONFIG_BUILD_BIN2C). And
now CONFIG_IKCONFIG and CONFIG_KEXEC will select CONFIG_BUILD_BIN2C.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
