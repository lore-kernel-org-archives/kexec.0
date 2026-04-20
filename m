Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B516F588EC
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lbmNztbEwLmjR0RQpM+PbvDofjBnkY5DWnlmbtfJfNk=; b=t5CUOU0PIw0igGFqFNurfrdkCN
	Tc7ndSQRwVaKRZWWlTaHhW/FJzWi23OCaGUeBkNYmKtpzUGY9F0KEu9mT4Z5vbp0fzZK+uEsp73U1
	MeHwfuy1G2mwiktfbeYsm8i7q8uqg534p5Z6JywXhnSUlzwn/GzICfYlfxwL3eIAJaDaVZiFT7CoX
	6qVO+IRnGDzji6fm/kwhTGATTXzLnTKljFGvITk3ELh2TCDXIdRAkdJ8HxtV4LoI3csAZA45RZgF6
	ZV9/9gwtyApUAxeMBmvh2U8VvTiQkMg2uyPZxwHKiuL6Zln/wrD4fIPMMlHqXGBpPOAPhQM2ABBMU
	v+nT2+Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEr0Z-00000007Nyz-1RAs;
	Mon, 20 Apr 2026 15:57:59 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEr0W-00000007NyT-2No8
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 15:57:58 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8a48deebe95so25920166d6.0
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776700675; x=1777305475; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lbmNztbEwLmjR0RQpM+PbvDofjBnkY5DWnlmbtfJfNk=;
        b=M1+jl1ehzIwR5E4z5IEbKhUdPvBHiAzlKN6KBDnedqMpC+PuHPAofVr+ZrIDaPpX0Z
         WGRcbF0Pc3aCKBpKit3y7y20mVsr0kXNIQaKBOu57Hxyj5eMo8HlNH+ccmv6xcUPqPTV
         pVnn6p+b5c7z36frUilVJ1jnKqUHhY0O16rQUXkUidVpmekTkuP8gLYFyr6KWze7IxTh
         RazkKJkXDdEFzEU8dCkspdqV+ERohdiuMP4zzWGr1AdQqPSKSCG3Xb+vMNQEIAjzUvgn
         3WuJhV2Zgd7yHxGe+YnbZQcK+EuEvpwfMo9hnDziMxezAu5CCOv5Rui9jm36uhuZElc2
         mnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776700675; x=1777305475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbmNztbEwLmjR0RQpM+PbvDofjBnkY5DWnlmbtfJfNk=;
        b=LZnrZ0eOvZHaOcQBFJKQI21TBPWP2LaPEg9Md316kfBOtrtqn86vfgCibBjL0H7ZiR
         RdCT7cywb6bArxwMZZ0KI9s9Z96G01uEPClcKm7r1XTtTaZlfGs/xwYJSmOKxIlrYAMm
         DXeMhJ8kA58IXNEw1J0Ov70QMX4APujwUWnqoc2MrK4weolaIZkN7CzTZmXsUNxd2oM2
         nny/4EH8zV33LHUzTFfJH9BL1IRJc42Brskv61kwbSWH/zTCqA8voqJIB1Bkd9eZKOdY
         ihZHlBxm/DpgiZ0rn/IbHWGuidIncQiiwfrdTX7pk+V8u/OTJWpZvsnJXiHI3UfU1gPr
         +nUg==
X-Forwarded-Encrypted: i=1; AFNElJ+YHh/7AKJ3h49sAycEnDkD86JEvf4z2Jbq6HGO6yFKlAeqVjRKmTvcUOhrhJlx3JRGax9C5Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzp6mALwSarxMATtdJAYuSbeTU9kCjcnhSqBBt1gY0qgx1EvTPo
	ofmqhPHctsEUnEkWmtW1/MhpNPQvPXSuGDu6oFMsc9DTqWfHeD7hfm0MW8y0p+Riczg=
X-Gm-Gg: AeBDievDGhk7fcYh+l7TleX03+HZDfxmyNC+Yx1BY7ZxO8wDy2oKOYYP2mT1r2KkTv0
	1pLJFXwC0L0znjCYKirIAtePk8+pTpZtpuCQWcxCjOV58Aayi1sZaqVn/PkJ7XIbENlBNSXvYyW
	XC4wH7ZAZCuOgLs63oTdE9x94nne3H46oQao+569MbxaLkATUk/6NRbbfRBnbdDAoV5HFvf86As
	uLmexyozFzv+cAqiorKuHIrufAIDwxu2iSS+VD+cMhf+88UvsXNFaWhI0Gkreviq8H7iTbRQxN7
	pIgHaeG+es0nRIW/wS0t9S6iJ0CmYLEsFa9t1ZF844cXsUY+J0CVL/HUMd8WLxuUqKz21/dnByv
	L/KFo6mVZbV5Hb9FUrFvRqK5ooth/XulCA8fgmHFRuWbBJY5hEcAP14bzUge2S/h3Foo5cgh4Gv
	wCKtlpVKYlHXvcydLZsIx8XtJBm7ePhC8mSCo/60xiInT0xnYEYFULuvySDLuu
X-Received: by 2002:a05:6214:4602:b0:89c:4f7f:8479 with SMTP id 6a1803df08f44-8b027ff9872mr248267446d6.6.1776700674494;
        Mon, 20 Apr 2026 08:57:54 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac7d4e6sm79178796d6.20.2026.04.20.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:57:54 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:57:53 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, luca.boccassi@gmail.com, 
	kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, rppt@kernel.org, 
	pratyush@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] liveupdate: add LUO_SESSION_MAGIC magic inode type
Message-ID: <fkz5u3nhgdm5k5qc77rioxon5gaxdgu7uuedqtixjq5evqrkzr@g23edpj4vmyo>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
 <20260418163358.2304490-4-luca.boccassi@gmail.com>
 <20260420-unbeeindruckt-besprach-910fd241c32e@brauner>
 <xpi24rt5ek2m2wkhv6celu75hgtgte2x4jhfkjar4gi22r7bdh@ilbxbhfxmm2v>
 <20260420-buchung-panne-57e262f5057f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-buchung-panne-57e262f5057f@brauner>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_085756_668016_B851A098 
X-CRM114-Status: GOOD (  45.86  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 04-20 17:28, Christian Brauner wrote:
> On Mon, Apr 20, 2026 at 02:55:56PM +0000, Pasha Tatashin wrote:
> > On 04-20 14:26, Christian Brauner wrote:
> > > On Sat, Apr 18, 2026 at 05:28:20PM +0100, luca.boccassi@gmail.com wrote:
> > > > From: Luca Boccassi <luca.boccassi@gmail.com>
> > > > 
> > > > In userspace when managing LUO sessions we want to be able to identify
> > > > a FD as a LUO session, in order to be able to do the special handling
> > > > that they require in order to function as intended on kexec.
> > > > 
> > > > Currently this requires scraping procfs and doing string matching on
> > > > the prefix of the dname, which is not an ideal interface.
> > > > 
> > > > Add a singleton inode type with a magic value, so that we can
> > > > programmatically identify a fd as a LUO session via fstatfs().
> > > > 
> > > > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > > > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > > ---
> > > >  include/uapi/linux/magic.h       |  1 +
> > > >  kernel/liveupdate/luo_core.c     | 10 +++-
> > > >  kernel/liveupdate/luo_internal.h |  2 +
> > > >  kernel/liveupdate/luo_session.c  | 89 ++++++++++++++++++++++++++++++--
> > > >  4 files changed, 96 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > > > index 4f2da935a76c..4f51005522ff 100644
> > > > --- a/include/uapi/linux/magic.h
> > > > +++ b/include/uapi/linux/magic.h
> > > > @@ -105,5 +105,6 @@
> > > >  #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
> > > >  #define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
> > > >  #define NULL_FS_MAGIC		0x4E554C4C	/* "NULL" */
> > > > +#define LUO_SESSION_MAGIC	0x4c554f53	/* "LUOS" */
> > > >  
> > > >  #endif /* __LINUX_MAGIC_H__ */
> > > > diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> > > > index dda7bb57d421..f1a63ebe4fa4 100644
> > > > --- a/kernel/liveupdate/luo_core.c
> > > > +++ b/kernel/liveupdate/luo_core.c
> > > > @@ -197,9 +197,17 @@ static int __init luo_late_startup(void)
> > > >  	if (!liveupdate_enabled())
> > > >  		return 0;
> > > >  
> > > > +	err = luo_session_fs_init();
> > > > +	if (err) {
> > > > +		luo_global.enabled = false;
> > > > +		return err;
> > > > +	}
> > > > +
> > > >  	err = luo_fdt_setup();
> > > > -	if (err)
> > > > +	if (err) {
> > > > +		luo_session_fs_cleanup();
> > > >  		luo_global.enabled = false;
> > > > +	}
> > > >  
> > > >  	return err;
> > > >  }
> > > > diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> > > > index 8083d8739b09..d4ac7b4c5882 100644
> > > > --- a/kernel/liveupdate/luo_internal.h
> > > > +++ b/kernel/liveupdate/luo_internal.h
> > > > @@ -79,6 +79,8 @@ struct luo_session {
> > > >  
> > > >  int luo_session_create(const char *name, struct file **filep);
> > > >  int luo_session_retrieve(const char *name, struct file **filep);
> > > > +int __init luo_session_fs_init(void);
> > > > +void __init luo_session_fs_cleanup(void);
> > > >  int __init luo_session_setup_outgoing(void *fdt);
> > > >  int __init luo_session_setup_incoming(void *fdt);
> > > >  int luo_session_serialize(void);
> > > > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> > > > index 5e316a4c5d71..21cbe99fc819 100644
> > > > --- a/kernel/liveupdate/luo_session.c
> > > > +++ b/kernel/liveupdate/luo_session.c
> > > > @@ -50,7 +50,6 @@
> > > >  
> > > >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > >  
> > > > -#include <linux/anon_inodes.h>
> > > >  #include <linux/cleanup.h>
> > > >  #include <linux/err.h>
> > > >  #include <linux/errno.h>
> > > > @@ -62,7 +61,10 @@
> > > >  #include <linux/libfdt.h>
> > > >  #include <linux/list.h>
> > > >  #include <linux/liveupdate.h>
> > > > +#include <linux/magic.h>
> > > > +#include <linux/mount.h>
> > > >  #include <linux/mutex.h>
> > > > +#include <linux/pseudo_fs.h>
> > > >  #include <linux/rwsem.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/unaligned.h>
> > > > @@ -363,18 +365,73 @@ static const struct file_operations luo_session_fops = {
> > > >  	.unlocked_ioctl = luo_session_ioctl,
> > > >  };
> > > >  
> > > > +static struct vfsmount *luo_session_mnt __ro_after_init;
> > > > +static struct inode *luo_session_inode __ro_after_init;
> > > > +
> > > > +/*
> > > > + * Reject all attribute changes on the singleton session inode.
> > > > + * Without this the VFS falls back to simple_setattr(), allowing
> > > > + * fchmod()/fchown() to modify the shared inode.
> > > > + */
> > > > +static int luo_session_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > > > +			       struct iattr *attr)
> > > 
> > > Don't duplicate, please. Use the generic helper instead:
> > > 
> > > int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > > 		       struct iattr *attr)
> > > 
> > > > +{
> > > > +	return -EOPNOTSUPP;
> > > 
> > > 
> > > 
> > > > +}
> > > > +
> > > > +static const struct inode_operations luo_session_inode_operations = {
> > > > +	.setattr	= luo_session_setattr,
> > > > +};
> > > > +
> > > > +static char *luo_session_dname(struct dentry *dentry, char *buffer, int buflen)
> > > > +{
> > > > +	return dynamic_dname(buffer, buflen, "luo_session:%s",
> > > > +			     dentry->d_name.name);
> > > 
> > > Use the luo_session:[%s] which is the canonical format for this
> > > (ignoring historcal abberations).
> > > 
> > > > +}
> > > > +
> > > > +static const struct dentry_operations luo_session_dentry_operations = {
> > > > +	.d_dname	= luo_session_dname,
> > > > +};
> > > > +
> > > > +static int luo_session_init_fs_context(struct fs_context *fc)
> > > > +{
> > > > +	struct pseudo_fs_context *ctx;
> > > > +
> > > > +	ctx = init_pseudo(fc, LUO_SESSION_MAGIC);
> > > 
> > > I'd just call that LUO_FS_MAGIC.
> > > 
> > > > +	if (!ctx)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	fc->s_iflags |= SB_I_NOEXEC;
> > > > +	fc->s_iflags |= SB_I_NODEV;
> > > 
> > >         ctx->s_d_flags |= DCACHE_DONTCACHE;
> > > 
> > > static const struct super_operations luo_session_sops = {
> > >         .drop_inode     = inode_just_drop,
> > >         .statfs         = simple_statfs,
> > > };
> > > 
> > > 
> > > > +	ctx->dops = &luo_session_dentry_operations;
> > > 
> > >         ctx->ops = &luo_session_sops;
> > > 
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static struct file_system_type luo_session_fs_type = {
> > > > +	.name = "luo_session",
> > > > +	.init_fs_context = luo_session_init_fs_context,
> > > > +	.kill_sb = kill_anon_super,
> > > > +};
> > > > +
> > > >  /* Create a "struct file" for session */
> > > >  static int luo_session_getfile(struct luo_session *session, struct file **filep)
> > > 
> > > Luo is going full anti-pattern here. This whole return via a function
> > > argument completely messes up the later codepths. We don't do manual
> > > get_unused_fd_flags() flags and then file in new code, and then fail
> > > in-between:
> > > 
> > >         argp->fd = get_unused_fd_flags(O_CLOEXEC);
> > >         if (argp->fd < 0)
> > >                 return argp->fd;
> > > 
> > >         err = luo_session_create(argp->name, &file);
> > >         if (err)
> > >                 goto err_put_fd;
> > > 
> > >         err = luo_ucmd_respond(ucmd, sizeof(*argp));
> > >         if (err)
> > >                 goto err_put_file;
> > > 
> > >         fd_install(argp->fd, file);
> > > 
> > > Restructure the code so it just becomes:
> > > 
> > > struct file *luo_session_create(argp->name);
> > > 
> > > static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
> > > {
> > >         struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
> > > 
> > >         return FD_ADD(O_CLOEXEC, luo_session_create(argp->name));
> > > }
> > > 
> > > and get rid of all this state and error handling. Please fix this.
> > 
> > We cannot do it this way because we must use copy_to_user() to return fd 
> > via ioctl(), and since copy_to_user() may fail, we must do it prior to 
> > fd_install().
> > 
> > Unless there is a specific VFS macro you'd prefer for this 
> > delayed-install pattern, I do not see any other way to do this but 
> > maintain the get_unused_fd_flags() -> copy_to_user() -> fd_install() to 
> > prevent the fd being leaked into the process's table.
> 
> The usercopy happens in luo_ucmd_respond it's perfectly fine if that
> fails. FD_ADD() handles all that. It reserves an fd, it opens the file
> and if that somehow fails it cleans up both the preallocated fd and the
> file (And if you need to do more stuff in between there's: FD_PREPARE()
> + fd_publish()).
> 
> What I meant is:
> 
> 	static struct file *luo_session_open(struct luo_ucmd *ucmd)
> 	{
> 		struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
> 	
> 		err = luo_ucmd_respond(ucmd, sizeof(*argp));

The fd is returned in 'argp->fd', not via ioctl() return value. so this 
response won't contain the fd number that will be returned to usersapce.

This is similar to how it is done in iommufd for example, see 

iommufd_fault_alloc()
	cmd->out_fault_fd = fdno;
	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
	fd_install(fdno, fault->common.filep); 
	return rc

Pasha

