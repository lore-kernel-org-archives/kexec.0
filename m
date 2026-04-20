Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C62F588DF
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L/2qYMFwJjwqGwHltRGn7Jh51mB0n8KEJgoVpDxZIHs=; b=ACjOO6et75sS0rD9hILJe61WR2
	yZi92l/SwMKqkZ+FuCE0Q2YPbistlzyt8J2QEyZdRWLEYY7udkBf+1T1GylxXWqBFrvc8INlNsSfy
	2BMY/BlC0uz5G6BPuskoSscmq5ArcyiEREiYcM2SkO8zvL6O9LNzz5lZ0aFhu72Q/E5pZYF3jno2y
	qxkyG0Slvx1r69zSAlvc5+3LzHbUydjcrz/1iTZOt4/Ljwinbu0OLfrqOXb9KnbK90svii4byoKEg
	LPRvXm2fsOSjphBHIFp/+RXL0u5VWBNwnUSPRLACdFdCsPaQCwVd/39GnHz1Mu0uzGrT8C4db/n6P
	SyNqY6lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEq2c-00000007Cee-1gyO;
	Mon, 20 Apr 2026 14:56:02 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEq2a-00000007CeC-0dyc
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 14:56:01 +0000
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-8ec37d52c0dso69430585a.0
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776696959; x=1777301759; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L/2qYMFwJjwqGwHltRGn7Jh51mB0n8KEJgoVpDxZIHs=;
        b=NPIcvOpW3QyL2P5fBNS7BxE6OpcXBHp6YnA52a/yEv+sB6Xtxbe6ArWeJ7VVFfigPe
         3uMWqhjuvjIy0xQtEZS794FGCGUNGjuNIE0nkkJbggr/lynFGYV5p8kh4qrUp1Fp8CvY
         gIL25hDR5LvV2p7/cm/sqc8Y7ubR5+PRIh+F5XzgkEcpQQUPKi1JQj0E2S8/2ivN9Izn
         ICUmdt0HRl1KamlACZrBAztQaicdFXWogA7EEakTkHAbvHH0EcPOIW4TxnXuSrnQokok
         KJwsUbKik33h5MNDTyxMy/+F7fi6TcXw1EYYZLpNko1nAVGcDJsajQhOi2uKaTrVf1at
         1P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776696959; x=1777301759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/2qYMFwJjwqGwHltRGn7Jh51mB0n8KEJgoVpDxZIHs=;
        b=LlhMtCCxgUGPnxqS/rBiCwVmU6rKFTymNuYGfvv8ZSR78+Dgf8+bkbGbZD+6RBQ7n/
         Mk+iJCsJUkxQ/BwPHZHErSs0vEz8TRxCqoQ/QFpnfNs3O4evRQAub6vk6UaDM/nEFWWm
         zNj2ns7gWlyvkJl1uMogl69ou+4OSrKbKFiA17gd/L+esyNlBnE28828eS2DUfJHYDE3
         VxOVfkB6xOPJdDodv27qIAYXrfTEjQnLsOsDh5mGYV/526vxa8uHlCnHT3hvxqis0F/l
         97TAN4KuGvQSzsrJy2Ljn3++D1MChEOpdjr9S5sLWWsm/XGjO2f/mN125tfHIUNgvhQb
         FBrg==
X-Forwarded-Encrypted: i=1; AFNElJ+6T91i24rDbYqUe6zAgSPW/yW3I8RvzIEman7OovKdWA3Q01/Uxwcr8oIG3tBY665tYGElZg==@lists.infradead.org
X-Gm-Message-State: AOJu0YymB3XvxWuZDqQgpdq3dLLurfh+CMl/3qTelnSulFkYZ+6un/pP
	hxF8ZnhbmbdtOZV69YdGBPwarrMn3s9V8fV0WNFcK5KIW1VAkkQNE3syzREY9FKAdVQ=
X-Gm-Gg: AeBDiesk9t4a3GnE9p7aAkX1a9BVDW1qr5bYW6eDXTD/I2PnjC4Yl0SJV/QQB/hmiXP
	LEvoYJHihy5X+PZjJUK8sBeXJeS8v+sfYaoa4h1ZBWQsVR5ll3jbmLzZzlhIwtzicbLHnliyMyd
	oGz/r8Uy+7gJ7adMFQsFPkMA9193wo4TGrcF7OudKhqts2tg65skq31DH9Oc2KfroiJYueJa4Is
	NR3nBcxdYM4zqbLPOxJPc8nXrz8Bj5fij9zGqv89xx2T5AuyS/Ri4qNY5XAf0YRb/BhN2gnq4mL
	7WaKec7DSaUrSQxP6r9n4+w6+R/TJPssL0/txfRSvBT9/hBAgfuw64rLbUqDYvbcHw5yMslDhyU
	UYCJ2RTNqYeE79tm6GIKJul24qYOPGn3/DSwpP8aDxoAKG7WosV6eUVRViz5009E7WH0Ho5Y0Kj
	0GBvRnfoeOiiNWfvHBuutYGIX2JN/awyITN+2XGQCGz+OfWj/7/URvyhTmcWZKcFG03oAahyo=
X-Received: by 2002:a05:620a:4014:b0:8d0:a0e:c7f6 with SMTP id af79cd13be357-8e7913c1f71mr1915472885a.38.1776696958490;
        Mon, 20 Apr 2026 07:55:58 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe9800sm816998685a.5.2026.04.20.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:55:58 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:55:56 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Christian Brauner <brauner@kernel.org>
Cc: luca.boccassi@gmail.com, kexec@lists.infradead.org, linux-mm@kvack.org, 
	graf@amazon.com, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] liveupdate: add LUO_SESSION_MAGIC magic inode type
Message-ID: <xpi24rt5ek2m2wkhv6celu75hgtgte2x4jhfkjar4gi22r7bdh@ilbxbhfxmm2v>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
 <20260418163358.2304490-4-luca.boccassi@gmail.com>
 <20260420-unbeeindruckt-besprach-910fd241c32e@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-unbeeindruckt-besprach-910fd241c32e@brauner>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_075600_227481_62AA7354 
X-CRM114-Status: GOOD (  53.10  )
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

On 04-20 14:26, Christian Brauner wrote:
> On Sat, Apr 18, 2026 at 05:28:20PM +0100, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> > 
> > In userspace when managing LUO sessions we want to be able to identify
> > a FD as a LUO session, in order to be able to do the special handling
> > that they require in order to function as intended on kexec.
> > 
> > Currently this requires scraping procfs and doing string matching on
> > the prefix of the dname, which is not an ideal interface.
> > 
> > Add a singleton inode type with a magic value, so that we can
> > programmatically identify a fd as a LUO session via fstatfs().
> > 
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/uapi/linux/magic.h       |  1 +
> >  kernel/liveupdate/luo_core.c     | 10 +++-
> >  kernel/liveupdate/luo_internal.h |  2 +
> >  kernel/liveupdate/luo_session.c  | 89 ++++++++++++++++++++++++++++++--
> >  4 files changed, 96 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > index 4f2da935a76c..4f51005522ff 100644
> > --- a/include/uapi/linux/magic.h
> > +++ b/include/uapi/linux/magic.h
> > @@ -105,5 +105,6 @@
> >  #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
> >  #define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
> >  #define NULL_FS_MAGIC		0x4E554C4C	/* "NULL" */
> > +#define LUO_SESSION_MAGIC	0x4c554f53	/* "LUOS" */
> >  
> >  #endif /* __LINUX_MAGIC_H__ */
> > diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> > index dda7bb57d421..f1a63ebe4fa4 100644
> > --- a/kernel/liveupdate/luo_core.c
> > +++ b/kernel/liveupdate/luo_core.c
> > @@ -197,9 +197,17 @@ static int __init luo_late_startup(void)
> >  	if (!liveupdate_enabled())
> >  		return 0;
> >  
> > +	err = luo_session_fs_init();
> > +	if (err) {
> > +		luo_global.enabled = false;
> > +		return err;
> > +	}
> > +
> >  	err = luo_fdt_setup();
> > -	if (err)
> > +	if (err) {
> > +		luo_session_fs_cleanup();
> >  		luo_global.enabled = false;
> > +	}
> >  
> >  	return err;
> >  }
> > diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> > index 8083d8739b09..d4ac7b4c5882 100644
> > --- a/kernel/liveupdate/luo_internal.h
> > +++ b/kernel/liveupdate/luo_internal.h
> > @@ -79,6 +79,8 @@ struct luo_session {
> >  
> >  int luo_session_create(const char *name, struct file **filep);
> >  int luo_session_retrieve(const char *name, struct file **filep);
> > +int __init luo_session_fs_init(void);
> > +void __init luo_session_fs_cleanup(void);
> >  int __init luo_session_setup_outgoing(void *fdt);
> >  int __init luo_session_setup_incoming(void *fdt);
> >  int luo_session_serialize(void);
> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> > index 5e316a4c5d71..21cbe99fc819 100644
> > --- a/kernel/liveupdate/luo_session.c
> > +++ b/kernel/liveupdate/luo_session.c
> > @@ -50,7 +50,6 @@
> >  
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> > -#include <linux/anon_inodes.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/err.h>
> >  #include <linux/errno.h>
> > @@ -62,7 +61,10 @@
> >  #include <linux/libfdt.h>
> >  #include <linux/list.h>
> >  #include <linux/liveupdate.h>
> > +#include <linux/magic.h>
> > +#include <linux/mount.h>
> >  #include <linux/mutex.h>
> > +#include <linux/pseudo_fs.h>
> >  #include <linux/rwsem.h>
> >  #include <linux/slab.h>
> >  #include <linux/unaligned.h>
> > @@ -363,18 +365,73 @@ static const struct file_operations luo_session_fops = {
> >  	.unlocked_ioctl = luo_session_ioctl,
> >  };
> >  
> > +static struct vfsmount *luo_session_mnt __ro_after_init;
> > +static struct inode *luo_session_inode __ro_after_init;
> > +
> > +/*
> > + * Reject all attribute changes on the singleton session inode.
> > + * Without this the VFS falls back to simple_setattr(), allowing
> > + * fchmod()/fchown() to modify the shared inode.
> > + */
> > +static int luo_session_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > +			       struct iattr *attr)
> 
> Don't duplicate, please. Use the generic helper instead:
> 
> int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> 		       struct iattr *attr)
> 
> > +{
> > +	return -EOPNOTSUPP;
> 
> 
> 
> > +}
> > +
> > +static const struct inode_operations luo_session_inode_operations = {
> > +	.setattr	= luo_session_setattr,
> > +};
> > +
> > +static char *luo_session_dname(struct dentry *dentry, char *buffer, int buflen)
> > +{
> > +	return dynamic_dname(buffer, buflen, "luo_session:%s",
> > +			     dentry->d_name.name);
> 
> Use the luo_session:[%s] which is the canonical format for this
> (ignoring historcal abberations).
> 
> > +}
> > +
> > +static const struct dentry_operations luo_session_dentry_operations = {
> > +	.d_dname	= luo_session_dname,
> > +};
> > +
> > +static int luo_session_init_fs_context(struct fs_context *fc)
> > +{
> > +	struct pseudo_fs_context *ctx;
> > +
> > +	ctx = init_pseudo(fc, LUO_SESSION_MAGIC);
> 
> I'd just call that LUO_FS_MAGIC.
> 
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> > +	fc->s_iflags |= SB_I_NOEXEC;
> > +	fc->s_iflags |= SB_I_NODEV;
> 
>         ctx->s_d_flags |= DCACHE_DONTCACHE;
> 
> static const struct super_operations luo_session_sops = {
>         .drop_inode     = inode_just_drop,
>         .statfs         = simple_statfs,
> };
> 
> 
> > +	ctx->dops = &luo_session_dentry_operations;
> 
>         ctx->ops = &luo_session_sops;
> 
> > +	return 0;
> > +}
> > +
> > +static struct file_system_type luo_session_fs_type = {
> > +	.name = "luo_session",
> > +	.init_fs_context = luo_session_init_fs_context,
> > +	.kill_sb = kill_anon_super,
> > +};
> > +
> >  /* Create a "struct file" for session */
> >  static int luo_session_getfile(struct luo_session *session, struct file **filep)
> 
> Luo is going full anti-pattern here. This whole return via a function
> argument completely messes up the later codepths. We don't do manual
> get_unused_fd_flags() flags and then file in new code, and then fail
> in-between:
> 
>         argp->fd = get_unused_fd_flags(O_CLOEXEC);
>         if (argp->fd < 0)
>                 return argp->fd;
> 
>         err = luo_session_create(argp->name, &file);
>         if (err)
>                 goto err_put_fd;
> 
>         err = luo_ucmd_respond(ucmd, sizeof(*argp));
>         if (err)
>                 goto err_put_file;
> 
>         fd_install(argp->fd, file);
> 
> Restructure the code so it just becomes:
> 
> struct file *luo_session_create(argp->name);
> 
> static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
> {
>         struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
> 
>         return FD_ADD(O_CLOEXEC, luo_session_create(argp->name));
> }
> 
> and get rid of all this state and error handling. Please fix this.

We cannot do it this way because we must use copy_to_user() to return fd 
via ioctl(), and since copy_to_user() may fail, we must do it prior to 
fd_install().

Unless there is a specific VFS macro you'd prefer for this 
delayed-install pattern, I do not see any other way to do this but 
maintain the get_unused_fd_flags() -> copy_to_user() -> fd_install() to 
prevent the fd being leaked into the process's table.

> 
> >  {
> > -	char name_buf[128];
> > +	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH + 1];
> >  	struct file *file;
> >  
> >  	lockdep_assert_held(&session->mutex);
> > -	snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
> > -	file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
> > -	if (IS_ERR(file))
> > +
> > +	ihold(luo_session_inode);
> 
> Right, you're now sharing the same inode among all luo sessions. So
> you've gained the ability to recognize luo inodes via fstatfs() but you
> still can't compare two luo session file descriptors for equality using
> stat() which is a major win and if you're doing this work anyway, let's

Luca, is there a specific use case in userspace where we need to compare 
LUO sessions for equality?

Christian's proposed solution of using unique inodes provides a standard 
VFS interface, but it introduces some memory overhead and, more 
importantly, a performance overhead due to the extra metadata 
allocations required during the performance-critical kexec blackout 
window.

I do not mind adding it, but I want to verify if this equality check is 
actually needed for your userspace agents, once we extend this, there is 
no way back.

> just go the extra step. You can mostly mirror pidfs and it's not
> difficult:
> 
> // unique inode numbers for the lifetime of the system instead of using
> // the shared ino allocator that can overflow
> 
> DEFINE_COOKIE(luo_session_cookie);
> 
> static u64 luo_alloc_ino(void)
> {
>         u64 ino;
> 
>         preempt_disable();
>         ino = gen_cookie_next(&luo_ino_cookie);
>         preempt_enable();
> 
>         VFS_WARN_ON_ONCE(ino < 1);
>         return ino;
> }
> 
> static struct inode *luo_new_inode()
> {
> 	inode = new_inode_pseudo(sb);
> 
> 	inode->i_flags	|= S_IMMUTABLE;
> 	inode->i_mode	|= S_IRWXU;
> 	inode->i_flags	|= S_PRIVATE | S_ANON_INODE;
> 	simple_inode_init_ts(inode);
> 
> 	inode->i_op	= &luo_session_inode_operations;
> 	// Make sure to leave inode->i_fop unset so it luo fds cannot be reopened via procfs
> 
> 	// Unique 64-bit inode. On 32-bit this will obviously be
> 	// truncated but a) LUO doesn't support 32-bit b) let's declare
> 	// anyone that wants LUO on 32-bit insane c) who uses more than
> 	// 32-bit worth of luo sessions d) if that's really something
> 	// you want to address you can do so later doing the same thing
> 	// I did for pidfs (see there for context).
>         inode->i_ino	= luo_alloc_ino();
>         inode->i_generation = pidfs_gen(pid->ino);
> 
> 	simple_inode_init_ts(inode);
> 	return inode;
> }
> 
> Now you can do
> 
> stat(fd_luo1, &st1);
> stat(fd_luo2, &st2);
> 
> if (st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino)
> 		return true; // same luo session
> 
> Sooner or later you will want this. Let's do it correctly, right now.
> 
> A bigger design question for the LUO people:
> 
> How do the lifetimes of the luo session and the luo fd relate to each
> other? The way the code is structured it looks like the luo session
> thing that you currently store in the file:
> 
>         file->private_data = session;
> 
> outlives the file? Why?
> 
> Imho, two things should change in addition to the switch to the tiny fs:
> 
> (1) The lifetime of the luo session object should be tied to the
>     lifetime of the session file descriptor so that when the last file
>     descriptor for that luo session is closed the @session thing gets
>     cleaned up. I assume that's the case anyway?
> 
> (2) Instead of stashing the session in file->private_data store it in
>     inode->private_data. This has various advantages:
> 
>     * You can stash other information in file->private_data.
>     * You can at some point have multiple files referring to the same
>       inode/luo session.
> 
> > +
> > +	snprintf(name_buf, sizeof(name_buf), "%s", session->name);
> > +	file = alloc_file_pseudo(luo_session_inode, luo_session_mnt, name_buf,
> > +				 O_RDWR, &luo_session_fops);
> > +	if (IS_ERR(file)) {
> > +		iput(luo_session_inode);
> >  		return PTR_ERR(file);
> > +	}
> >  
> > +	file->private_data = session;
> >  	*filep = file;
> >  
> >  	return 0;
> > @@ -653,3 +710,25 @@ void luo_session_resume(void)
> >  	up_write(&luo_session_global.outgoing.rwsem);
> >  	up_write(&luo_session_global.incoming.rwsem);
> >  }
> > +
> > +int __init luo_session_fs_init(void)
> > +{
> > +	luo_session_mnt = kern_mount(&luo_session_fs_type);
> > +	if (IS_ERR(luo_session_mnt))
> 
> panic()
> 
> > +		return PTR_ERR(luo_session_mnt);
> > +
> > +	luo_session_inode = alloc_anon_inode(luo_session_mnt->mnt_sb);
> > +	if (IS_ERR(luo_session_inode)) {
> > +		kern_unmount(luo_session_mnt);
> > +		return PTR_ERR(luo_session_inode);
> > +	}
> > +	luo_session_inode->i_op = &luo_session_inode_operations;
> 
> Kill all of this now that you allocate inodes on-demand.
> 
> > +
> > +	return 0;
> > +}
> > +
> > +void __init luo_session_fs_cleanup(void)
> > +{
> > +	iput(luo_session_inode);
> > +	kern_unmount(luo_session_mnt);
> > +}
> > -- 
> > 2.47.3
> > 

