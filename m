Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97960A3804
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LpO0ywV0;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Kf4/V3k7;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0sClAhd5;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Kf4/V3k7;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0sClAhd5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8GztbmdPIq1W7yvyzWknacNZFNOoqhx0Fy+nAHd0FJc=; b=LpO0ywV0X+nmT7u2oUjigMAvZ6
	4+TM4dDcF9FiXuvYGwLMgvTUjArLyUaCIw0ejQSFRsSQxIj71HDsAGTy7ygyzyrFzAsUwPDizN0oi
	J16f/KR2huBwkhNuOR3CLWLiHmCrIUhVGuXNT2xaaM4NcvE9IT37qg/I755B3yx0/KsVh6MqocEBb
	VQY9lYhogxv5960qBh4IrN76wruMnl/ndAhPz9itgyAT//FZA43a6g6j4ImhMz5qFuRrlVYopjiiG
	v+VyR69ev8Ac6L9FfiT6rlQDi0tSjVqp4LUiwakjNkiDOnO6zP1yn1ncGRs/AA6BrT/fQI7zTbpTP
	mu8yKDgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQmwD-00000004DbD-0G8X;
	Tue, 10 Nov 2026 14:35:05 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQmwA-00000004DaN-1raC;
	Tue, 10 Nov 2026 14:35:04 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2F11F7E9;
	Tue, 10 Nov 2026 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794321300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GztbmdPIq1W7yvyzWknacNZFNOoqhx0Fy+nAHd0FJc=;
	b=Kf4/V3k7uJ3/e8gJIc8Yq2RfTu9sqtfttw7+/XtgLjAgzqpseC8KVY0cIt3vE7gewsFtgS
	Ul25YQuPGcy+MdjCiZ01nYNZL6oIl9h+7CtWLxqD0DCE7dLCT4LVtl2+MaCEOzBnO5VmYl
	TqvBQPF83X/L0SH3n0hrFLzjLD0A3pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794321300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GztbmdPIq1W7yvyzWknacNZFNOoqhx0Fy+nAHd0FJc=;
	b=0sClAhd5uG01XGSIXIU41VEvI9NfiuUN4ZK34eq4spWakFMk8sOp9e0DDfiJbg/Z9APkfg
	hTmYlGV16kkIijCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Kf4/V3k7";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0sClAhd5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794321300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GztbmdPIq1W7yvyzWknacNZFNOoqhx0Fy+nAHd0FJc=;
	b=Kf4/V3k7uJ3/e8gJIc8Yq2RfTu9sqtfttw7+/XtgLjAgzqpseC8KVY0cIt3vE7gewsFtgS
	Ul25YQuPGcy+MdjCiZ01nYNZL6oIl9h+7CtWLxqD0DCE7dLCT4LVtl2+MaCEOzBnO5VmYl
	TqvBQPF83X/L0SH3n0hrFLzjLD0A3pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794321300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GztbmdPIq1W7yvyzWknacNZFNOoqhx0Fy+nAHd0FJc=;
	b=0sClAhd5uG01XGSIXIU41VEvI9NfiuUN4ZK34eq4spWakFMk8sOp9e0DDfiJbg/Z9APkfg
	hTmYlGV16kkIijCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBD091339F;
	Tue, 10 Nov 2026 14:34:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eH+6KJMr82prKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Nov 2026 14:34:59 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 5190222543; Tue, 10 Nov 2026 15:34:59 +0100 (CET)
Date: Tue, 10 Nov 2026 15:34:59 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
	Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Eric Dumazet <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados <joel.granados@kernel.org>, 
	Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	netdev@vger.kernel.org, ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
	coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
	sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, 
	Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 32/51] proc: resume readdir after the last name it
 returned
Message-ID: <67qeb525vqah4cjisunzwemua7rf2xj4esnlo2xl3t6crnqmzc@lsuqyjwenpx4>
References: <20261104-work-procfs-bugfixes-v2-0-bbf7d5546809@kernel.org>
 <20261104-work-procfs-bugfixes-v2-32-bbf7d5546809@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-work-procfs-bugfixes-v2-32-bbf7d5546809@kernel.org>
X-Rspamd-Queue-Id: 0F2F11F7E9
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-11.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLpnapcpkwxdkc5mopt1ezhhna)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.51
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_063502_786796_A1A26B07 
X-CRM114-Status: GOOD (  44.08  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed 04-11-26 18:47:18, Christian Brauner wrote:
> proc_readdir_de() counts the entries of a directory and resumes a
> listing at the number getdents64() stopped at. The entries are sorted
> by name, so one that is added or removed in between shifts everything
> behind it by one. Listing /proc/net/dev_snmp6 with a buffer that holds
> ".", ".." and "lo" and adding a device whose name sorts before "lo"
> makes the next call return "lo" a second time. Removing one that sorted
> before the position makes the next call skip an entry instead.
> 
> Since commit 895b4c0c79b0 ("fs/proc: fix uaf in proc_readdir_de()") an
> entry that is removed while it is being emitted also ends the listing
> right there. pde_subdir_next() finds nothing after an erased entry, so
> proc_readdir_de() reports the end of the directory and the next call
> resumes by number, skipping another entry. For /proc itself
> proc_root_readdir() takes that as the end of the static entries and
> moves on to the pids, so the rest of the static entries is missing.
> And if the position is behind the last entry when a call starts
> proc_readdir_de() returns 0, so /proc then lists no pids at all.
> 
> So remember the name of the last entry a call emitted in the file and
> resume at the first entry after it, like kernfs resumes after the node
> it stopped at. An entry that was removed while it was emitted is
> continued after by its name as well. If the position was moved by a
> seek in between the listing counts from the start like before.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 895b4c0c79b0 ("fs/proc: fix uaf in proc_readdir_de()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/proc/generic.c  | 89 ++++++++++++++++++++++++++++++++++++++++++++++--------
>  fs/proc/internal.h |  1 +
>  fs/proc/proc_net.c |  1 +
>  fs/proc/root.c     |  1 +
>  4 files changed, 80 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 9e59796349e1..588999058e66 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -87,6 +87,28 @@ static struct proc_dir_entry *pde_subdir_find(struct proc_dir_entry *dir,
>  	return NULL;
>  }
>  
> +/* The first entry of @dir that sorts after @name. */
> +static struct proc_dir_entry *pde_subdir_after(struct proc_dir_entry *dir,
> +					       const char *name,
> +					       unsigned int len)
> +{
> +	struct rb_node *node = dir->subdir.rb_node, *after = NULL;
> +
> +	while (node) {
> +		struct proc_dir_entry *de = rb_entry(node,
> +						     struct proc_dir_entry,
> +						     subdir_node);
> +
> +		if (proc_match(name, de, len) < 0) {
> +			after = node;
> +			node = node->rb_left;
> +		} else {
> +			node = node->rb_right;
> +		}
> +	}
> +	return rb_entry_safe(after, struct proc_dir_entry, subdir_node);
> +}
> +
>  static bool pde_subdir_insert(struct proc_dir_entry *dir,
>  			      struct proc_dir_entry *de)
>  {
> @@ -278,6 +300,40 @@ struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
>  	return proc_lookup_de(dir, dentry, PDE(dir));
>  }
>  
> +/*
> + * Where the next readdir resumes. The entries are counted, so one that is
> + * added or removed in front of the position would shift what the next call
> + * returns. The name of the last entry emitted doesn't move.
> + */
> +struct proc_dir_cursor {
> +	loff_t pos;			/* the position behind the entry */
> +	unsigned int len;
> +	char name[NAME_MAX + 1];
> +};
> +
> +/* If this can't remember the entry the next call counts from the start. */
> +static void proc_dir_cursor_set(struct file *file, struct proc_dir_entry *de,
> +				loff_t pos)
> +{
> +	struct proc_dir_cursor *cursor = file->private_data;
> +
> +	if (!cursor) {
> +		cursor = kmalloc(sizeof(*cursor), GFP_KERNEL);
> +		if (!cursor)
> +			return;
> +		file->private_data = cursor;
> +	}
> +	cursor->pos = pos;
> +	cursor->len = de->namelen;
> +	memcpy(cursor->name, de->name, de->namelen);
> +}
> +
> +int proc_dir_release(struct inode *inode, struct file *file)
> +{
> +	kfree(file->private_data);
> +	return 0;
> +}
> +
>  /*
>   * This returns non-zero if at EOF, so that the /proc
>   * root directory can use this and check if it should
> @@ -290,23 +346,26 @@ struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
>  int proc_readdir_de(struct file *file, struct dir_context *ctx,
>  		    struct proc_dir_entry *de)
>  {
> +	struct proc_dir_cursor *cursor = file->private_data;
> +	struct proc_dir_entry *dir = de;
>  	int i;
>  
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
>  
> -	i = ctx->pos - 2;
>  	read_lock(&proc_subdir_lock);
> -	de = pde_subdir_first(de);
> -	for (;;) {
> -		if (!de) {
> -			read_unlock(&proc_subdir_lock);
> -			return 0;
> -		}
> -		if (!i)
> -			break;
> -		de = pde_subdir_next(de);
> -		i--;
> +	if (cursor && cursor->pos == ctx->pos) {
> +		/* Resume after the last entry emitted, wherever it is now. */
> +		de = pde_subdir_after(dir, cursor->name, cursor->len);
> +	} else {
> +		/* Moved by a seek, count from the start like always. */
> +		de = pde_subdir_first(dir);
> +		for (i = ctx->pos - 2; de && i; i--)
> +			de = pde_subdir_next(de);
> +	}
> +	if (!de) {
> +		read_unlock(&proc_subdir_lock);
> +		return 1;
>  	}
>  
>  	do {
> @@ -319,8 +378,13 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
>  			return 0;
>  		}
>  		ctx->pos++;
> +		proc_dir_cursor_set(file, de, ctx->pos);
>  		read_lock(&proc_subdir_lock);
> -		next = pde_subdir_next(de);
> +		/* Removed in the meantime, go on after its name. */
> +		if (RB_EMPTY_NODE(&de->subdir_node))
> +			next = pde_subdir_after(dir, de->name, de->namelen);
> +		else
> +			next = pde_subdir_next(de);
>  		pde_put(de);
>  		de = next;
>  	} while (de);
> @@ -348,6 +412,7 @@ static const struct file_operations proc_dir_operations = {
>  	.llseek			= generic_file_llseek,
>  	.read			= generic_read_dir,
>  	.iterate_shared		= proc_readdir,
> +	.release		= proc_dir_release,
>  };
>  
>  static int proc_net_d_revalidate(struct inode *dir, const struct qstr *name,
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index df873df9afc5..04f7ce2b24ed 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -287,6 +287,7 @@ extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int)
>  struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
>  extern int proc_readdir(struct file *, struct dir_context *);
>  int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *);
> +int proc_dir_release(struct inode *, struct file *);
>  
>  static inline void pde_get(struct proc_dir_entry *pde)
>  {
> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index b1f5eafb069a..dbcf87a257e1 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -351,6 +351,7 @@ const struct file_operations proc_net_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read		= generic_read_dir,
>  	.iterate_shared	= proc_tgid_net_readdir,
> +	.release	= proc_dir_release,
>  };
>  
>  static __net_init int proc_net_ns_init(struct net *net)
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 7fbbe92bf73a..dfee1caa26f7 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -441,6 +441,7 @@ static const struct file_operations proc_root_operations = {
>  	.read		 = generic_read_dir,
>  	.iterate_shared	 = proc_root_readdir,
>  	.llseek		= generic_file_llseek,
> +	.release	= proc_dir_release,
>  };
>  
>  /*
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

