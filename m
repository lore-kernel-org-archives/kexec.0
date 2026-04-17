Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F145F99C60
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 20:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BWgweBTv8b3MTcGI0y+qlYOhAPey2TLsgfFaPFmrVDo=; b=l4VoFA8A7ZFUYSyifERYZvDyih
	afut+Bwn8/J7AMUANWBjymQcFKRwLr3AKeOqztmeu0sSW1RBlhnt9fX4ltMsQFyY+z6W6A3etMs8u
	fiLYFqZvppSS4hhAP44pPqYfoLnDcQemkIQ55zXuBcoByb9SJJ3KSxBvyrOWCMEMmeCzt+xkU6WSu
	/BzWQgsCPiSb/dfjel7bZFnom79iqFKPaZlaJMKzrLdE+Rd6D6H5lJYGdEVumc0VfVHrPXIfl2+76
	mUHdFEZQ0NDHAtFxNskC8gRW4t85lNmWc9UvPlw8dAtFlDvxA9DP6qiUxL7RSEHOFZ1yesdpvQ0tS
	hiksQFyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDqBz-00000004Srs-0DxY;
	Fri, 17 Apr 2026 20:53:35 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDqBw-00000004SrV-1pXG
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 20:53:33 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-50dedb18ea0so8950891cf.3
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776459211; x=1777064011; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWgweBTv8b3MTcGI0y+qlYOhAPey2TLsgfFaPFmrVDo=;
        b=FIAvq+nskw7Jt9swgWMZxb0ip3f/bSa7aGkUEEOrT0Hr7L5/C2lvKBEjaK9tQ4AFpC
         VKdoUEpA5gGrcVmaQOLov7CDvPpmzNyy40Brr/56NFiyDAboQgdrWA5/w4nNXyDOP++8
         eGBXp6V6wGOPWGU3hYPxzoDlNnrYZp9c7X3E4TE8dVSdhb9L6Yts8WBsar3heC7IW3HW
         WpTocugZFTj/hSVG1a8ylt8+r+D0oO2AQ5UP6Y29x1Xt+ldJtl1rtWdEv8G8WKtwE+Rl
         W7qoUt3xyhjOMr8LVF66/HwYmE9S/E+qwe9UcNYLo1MUiT3VfnlrSgmnOGEuQ4Ir0EQr
         pulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776459211; x=1777064011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWgweBTv8b3MTcGI0y+qlYOhAPey2TLsgfFaPFmrVDo=;
        b=IvSa0MMxvsN+nROY+MfL91wDgXP41JMnQCjHePatM53ZlIAiRKzSJIAyEbBtj/4Zh+
         sMQLLUA3KdGd1RcASvWlMHt3M8o07lv85BGU/m2uF2V0occuAojVQwIGd2LAY46/4+Fi
         a3M5HHUlNNGAhJP5FKJ9VYhcUFHYeH1Vi7n/kf+cUVS+0iqxBiC4CH8oguJYJ/qToeMx
         gr2RSTbwut4wRCZ4YQ7ojNC027X9Fticmhd3a6VDIPTgUNmRTkIB5J6TuaGDWbR30XK3
         sFimYkKuSrvido5P6/2KeaMly6lOAZ7jITW8jHHuCl3CNFWFjkvCEoh9vfrtZUjUcumU
         MOLQ==
X-Gm-Message-State: AOJu0Yx5LG8QQ0tvwV3C6uSdmK47qiBqGY6dDJOrOyFUZMpnIzZeniW7
	frm9m8QSbXaWOrtm8pC35wY5c+e3EBMo3OijB73DVP3xGccpKUu0OzFn80MfEKpjeZ0=
X-Gm-Gg: AeBDiesKxUCnIfK545JmOqsZeGZoz3n98j5Pjxc2kqzaKm5pqitDpjcmBszULP2ajd+
	9wcJPOjyFPSxy5UTJJIJvw6bQu7/jWuAc9w/TY7lZB3XOLKducQZWPu4pHCtzevaHHDNwMO0r8F
	Myt4/Rq+cIMhR4YDKkiuebXWTXDfaUBda5wIDK6ToCN7HoQhU3orZzTsCya6ljm6f58BvQxaV3q
	VU1W049GkFI/qXbC7v7sFolZP3WNgOeZm+4nMf0BLuuDjtnHug9jW7Drrl9bh/r5JldD41d5Zw6
	ajuIWVJCPvhMmQNrUoLs7rcgfsH/7j5M3f6kBnC4YwFCwZd5e3kKW0HEslw6JeZeONWUJE4OG7V
	4mnfGMqylTomTIa1nqhtnpvWXvM1j7maepCMQxPOhhh7KwsB4BziAbnKl9grfHmtewkjiXHL9cr
	7KmJHCbBxhSdbgx8QZn31RjolaffqI7Ev0vMNRaSSCRnn99UsdQp1e47UVDkSC
X-Received: by 2002:ac8:5788:0:b0:509:68c:634d with SMTP id d75a77b69052e-50e3682797bmr67515491cf.10.1776459210731;
        Fri, 17 Apr 2026 13:53:30 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e392c8575sm19930751cf.3.2026.04.17.13.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:53:30 -0700 (PDT)
Date: Fri, 17 Apr 2026 20:53:28 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com
Subject: Re: [PATCH v3] liveupdate: add LUO_SESSION_MAGIC magic inode type
Message-ID: <547dc4f7xmafywo7jfeuordj5uwaq5lq4zfdupvswxy5yn5osj@v67ia535jnfw>
References: <20260417204039.1827319-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417204039.1827319-1-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_135332_545766_8FC5BC36 
X-CRM114-Status: GOOD (  33.46  )
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

On 04-17 21:40, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> In userspace when managing LUO sessions we want to be able to identify
> a FD as a LUO session, in order to be able to do the special handling
> that they require in order to function as intended on kexec.
> 
> Currently this requires scraping procfs and doing string matching on
> the prefix of the dname, which is not an ideal interface.
> 
> Add a singleton inode type with a magic value, so that we can
> programmatically identify a fd as a LUO session via fstat().
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---
> This was requested by Lennart and Christian when discussing integration
> with systemd for LUO management.
> 
> v2: apply one fix from bot review about cleanup on error path:
>     https://sashiko.dev/#/patchset/20260415184536.1155220-1-luca.boccassi%40gmail.com
>     the other comments are invalid: luo is not a kmod, and the write hooks are not set up
> v3: add test case to liveupdate selftest

This should be split into two patches, also please CC:
linux-kernel@vger.kernel.org

> 
>  include/uapi/linux/magic.h                    |  1 +
>  kernel/liveupdate/luo_core.c                  | 10 ++-
>  kernel/liveupdate/luo_internal.h              |  2 +
>  kernel/liveupdate/luo_session.c               | 73 +++++++++++++++++--
>  .../testing/selftests/liveupdate/liveupdate.c | 40 ++++++++++
>  5 files changed, 120 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 4f2da935a76cc..4f51005522ffe 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -105,5 +105,6 @@
>  #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
>  #define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
>  #define NULL_FS_MAGIC		0x4E554C4C	/* "NULL" */
> +#define LUO_SESSION_MAGIC	0x4c554f53	/* "LUOS" */
>  
>  #endif /* __LINUX_MAGIC_H__ */
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index dda7bb57d421c..f1a63ebe4fa44 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -197,9 +197,17 @@ static int __init luo_late_startup(void)
>  	if (!liveupdate_enabled())
>  		return 0;
>  
> +	err = luo_session_fs_init();
> +	if (err) {
> +		luo_global.enabled = false;
> +		return err;
> +	}
> +
>  	err = luo_fdt_setup();
> -	if (err)
> +	if (err) {
> +		luo_session_fs_cleanup();
>  		luo_global.enabled = false;
> +	}
>  
>  	return err;
>  }
> diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> index 8083d8739b093..d4ac7b4c58829 100644
> --- a/kernel/liveupdate/luo_internal.h
> +++ b/kernel/liveupdate/luo_internal.h
> @@ -79,6 +79,8 @@ struct luo_session {
>  
>  int luo_session_create(const char *name, struct file **filep);
>  int luo_session_retrieve(const char *name, struct file **filep);
> +int __init luo_session_fs_init(void);
> +void __init luo_session_fs_cleanup(void);
>  int __init luo_session_setup_outgoing(void *fdt);
>  int __init luo_session_setup_incoming(void *fdt);
>  int luo_session_serialize(void);
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index af9e498206d24..f30151c37bd43 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -50,7 +50,6 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/anon_inodes.h>
>  #include <linux/cleanup.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> @@ -62,7 +61,10 @@
>  #include <linux/libfdt.h>
>  #include <linux/list.h>
>  #include <linux/liveupdate.h>
> +#include <linux/magic.h>
> +#include <linux/mount.h>
>  #include <linux/mutex.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/rwsem.h>
>  #include <linux/slab.h>
>  #include <linux/unaligned.h>
> @@ -376,18 +378,58 @@ static const struct file_operations luo_session_fops = {
>  	.unlocked_ioctl = luo_session_ioctl,
>  };
>  
> +static struct vfsmount *luo_session_mnt __ro_after_init;
> +static struct inode *luo_session_inode __ro_after_init;
> +
> +static char *luo_session_dname(struct dentry *dentry, char *buffer, int buflen)
> +{
> +	return dynamic_dname(buffer, buflen, "luo_session:%s",
> +			     dentry->d_name.name);
> +}
> +
> +static const struct dentry_operations luo_session_dentry_operations = {
> +	.d_dname	= luo_session_dname,
> +};
> +
> +static int luo_session_init_fs_context(struct fs_context *fc)
> +{
> +	struct pseudo_fs_context *ctx;
> +
> +	ctx = init_pseudo(fc, LUO_SESSION_MAGIC);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	fc->s_iflags |= SB_I_NOEXEC;
> +	fc->s_iflags |= SB_I_NODEV;
> +	ctx->dops = &luo_session_dentry_operations;
> +	return 0;
> +}
> +
> +static struct file_system_type luo_session_fs_type = {
> +	.name = "luo_session",
> +	.init_fs_context = luo_session_init_fs_context,
> +	.kill_sb = kill_anon_super,
> +};
> +
>  /* Create a "struct file" for session */
>  static int luo_session_getfile(struct luo_session *session, struct file **filep)
>  {
> -	char name_buf[128];
> +	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH + 1];
>  	struct file *file;
>  
>  	lockdep_assert_held(&session->mutex);
> -	snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
> -	file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
> -	if (IS_ERR(file))
> +
> +	ihold(luo_session_inode);
> +
> +	snprintf(name_buf, sizeof(name_buf), "%s", session->name);
> +	file = alloc_file_pseudo(luo_session_inode, luo_session_mnt, name_buf,
> +				 O_RDWR, &luo_session_fops);
> +	if (IS_ERR(file)) {
> +		iput(luo_session_inode);
>  		return PTR_ERR(file);
> +	}
>  
> +	file->private_data = session;
>  	*filep = file;
>  
>  	return 0;
> @@ -662,3 +704,24 @@ void luo_session_resume(void)
>  	up_write(&luo_session_global.outgoing.rwsem);
>  	up_write(&luo_session_global.incoming.rwsem);
>  }
> +
> +int __init luo_session_fs_init(void)
> +{
> +	luo_session_mnt = kern_mount(&luo_session_fs_type);
> +	if (IS_ERR(luo_session_mnt))
> +		return PTR_ERR(luo_session_mnt);
> +
> +	luo_session_inode = alloc_anon_inode(luo_session_mnt->mnt_sb);
> +	if (IS_ERR(luo_session_inode)) {
> +		kern_unmount(luo_session_mnt);
> +		return PTR_ERR(luo_session_inode);
> +	}
> +
> +	return 0;
> +}
> +
> +void __init luo_session_fs_cleanup(void)
> +{
> +	iput(luo_session_inode);
> +	kern_unmount(luo_session_mnt);
> +}
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index bdc1cedc4f944..27b3cbff6c739 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -22,9 +22,12 @@
>  #include <fcntl.h>
>  #include <string.h>
>  #include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <sys/vfs.h>
>  #include <unistd.h>
>  
>  #include <linux/liveupdate.h>
> +#include <linux/magic.h>
>  
>  #include "../kselftest.h"
>  #include "../kselftest_harness.h"
> @@ -416,4 +419,41 @@ TEST_F(liveupdate_device, get_session_name_max_length)
>  	ASSERT_EQ(close(session_fd), 0);
>  }
>  
> +/*
> + * Test Case: Session fstat
> + *
> + * Verifies that fstatfs() on a session file descriptor reports the
> + * LUO_SESSION_MAGIC filesystem type, and that fstat() returns consistent
> + * inode numbers across different sessions (shared singleton inode).
> + */
> +TEST_F(liveupdate_device, session_fstat)
> +{
> +	int session_fd1, session_fd2;
> +	struct statfs sfs;
> +	struct stat st1, st2;

Reverse-christmast-tree order please.

> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	session_fd1 = create_session(self->fd1, "fstat-session-1");
> +	ASSERT_GE(session_fd1, 0);
> +
> +	session_fd2 = create_session(self->fd1, "fstat-session-2");
> +	ASSERT_GE(session_fd2, 0);
> +
> +	/* Verify the filesystem type is LUO_SESSION_MAGIC */
> +	ASSERT_EQ(fstatfs(session_fd1, &sfs), 0);
> +	EXPECT_EQ(sfs.f_type, LUO_SESSION_MAGIC);
> +
> +	/* Verify both sessions share the same inode number */
> +	ASSERT_EQ(fstat(session_fd1, &st1), 0);
> +	ASSERT_EQ(fstat(session_fd2, &st2), 0);
> +	EXPECT_EQ(st1.st_ino, st2.st_ino);
> +
> +	ASSERT_EQ(close(session_fd1), 0);
> +	ASSERT_EQ(close(session_fd2), 0);
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.47.3
> 

