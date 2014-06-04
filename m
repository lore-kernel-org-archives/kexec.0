Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsFLC-0007o8-D8
 for kexec@lists.infradead.org; Wed, 04 Jun 2014 17:51:11 +0000
Date: Wed, 4 Jun 2014 13:50:31 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 00/13][V3] kexec: A new system call to allow in
 kernel loading
Message-ID: <20140604175031.GA4406@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <20140603131203.GA23395@redhat.com>
 <20140604092214.GA17528@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140604092214.GA17528@dhcp-17-89.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com

On Wed, Jun 04, 2014 at 05:22:14PM +0800, WANG Chao wrote:

[..]
> > Index: kexec-tools/kexec/kexec.h
> > ===================================================================
> > --- kexec-tools.orig/kexec/kexec.h	2014-06-02 14:34:16.719774316 -0400
> > +++ kexec-tools/kexec/kexec.h	2014-06-02 14:34:42.010036325 -0400
> > @@ -156,6 +156,13 @@ struct kexec_info {
> >  	unsigned long kexec_flags;
> >  	unsigned long backup_src_start;
> >  	unsigned long backup_src_size;
> > +	/* Set to 1 if we are using kexec2 syscall */
> > +	unsigned long file_mode :1;
> > +
> > +	/* Filled by kernel image processing code */
> > +	int initrd_fd;
> > +	char *command_line;
> > +	int command_line_len;
> >  };
> >  
> >  struct arch_map_entry {
> > @@ -207,6 +214,7 @@ extern int file_types;
> >  #define OPT_UNLOAD		'u'
> >  #define OPT_TYPE		't'
> >  #define OPT_PANIC		'p'
> > +#define OPT_USE_KEXEC2_SYSCALL	's'
> >  #define OPT_MEM_MIN             256
> >  #define OPT_MEM_MAX             257
> >  #define OPT_REUSE_INITRD	258
> > @@ -230,6 +238,7 @@ extern int file_types;
> >  	{ "mem-min",		1, 0, OPT_MEM_MIN }, \
> >  	{ "mem-max",		1, 0, OPT_MEM_MAX }, \
> >  	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
> > +	{ "use-kexec2-syscall",	0, 0, OPT_USE_KEXEC2_SYSCALL }, \
> >  	{ "debug",		0, 0, OPT_DEBUG }, \
> >  
> >  #define KEXEC_OPT_STR "h?vdfxluet:p"
> 
> This line,
> #define KEXEC_OPT_STR "h?vdfxluet:p"
> 
> should be something like,
> #define KEXEC_OPT_STR "h?vdfxluet:ps"

Thanks chao. I will fix it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
