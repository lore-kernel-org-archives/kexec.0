Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266E1F588E5
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ZDajwN8h+CL1MQszF1BlglSh2vpB8Y3M8aLlxS+8+8=; b=DEu76POc/8xINmXnOSWEUxVDz6
	YcTsEnWk8EhAPUO8bhAYyCziphP0wZHSVzyWJhprT9K/oU6dwfy8JPfkXhr+601iMiLYnflaTIiTK
	YDw4+0RHxeUyl8+ohioq88/87IGKIe/kWkBcw7BoAGJqowjoYUSHiGPlYNC+opJEHuUh7TpNecZ/C
	zjY/dJ8qKTrWkXQOeRDdhlCleMQ8UwaSrPKA/ZftyLJl3Bz1YylppEbRwja9OmAKz9jTQ0PAlYndB
	jJO+bVNW4DFWa6j2cli2gPo2xbBcHlNxVwselj2EsEJRzBkM0ZfI7z0CGF/bfFQYRN0XcUWfNAhrL
	qUqVj4nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEqBs-00000007Df0-1Cms;
	Mon, 20 Apr 2026 15:05:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEqBp-00000007Ddy-12WV
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 15:05:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3680D40E56;
	Mon, 20 Apr 2026 15:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE406C19425;
	Mon, 20 Apr 2026 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776697532;
	bh=9bLC3fbNgVoVZV+KFNSikVGR7fHetTFRztZOfON4clk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3U3twt5iJWmmw2MWXIcVTyCgRT4dp3vXi2ud2ujX6nxbgeWsfyYTgInJSedCkuN1
	 fHAjs5kf3LUKgwzgxoxgAhKIew9frlQ+AwERh1twDt3eIezYZ3ynJel3S/btyNmsCw
	 Gaw1V4Fk/smkK8FgNHASbXOZIDxVbxe6rHS4I7S6CYfRHstyee+q4spnvhnTavJRY9
	 /m5v9hrkwwnficPNXIPFvCP1mbQTvC1ju6Ub3dvm2YUFz9SDn0ahJvqUzSmebGLfnJ
	 /4JrnngWFfqW7H57T9jmRDxg6Us21z5pQHVuze1QRow57pNRcdBdZPglZEAEMRXjV2
	 UoduwH/7E4bRA==
Date: Mon, 20 Apr 2026 17:05:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] liveupdate: add LUO_SESSION_MAGIC magic inode type
Message-ID: <20260420-zunehmen-eishalle-3a5084c66375@brauner>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
 <20260418163358.2304490-4-luca.boccassi@gmail.com>
 <20260420-unbeeindruckt-besprach-910fd241c32e@brauner>
 <CAMw=ZnR0uVrHUNzNGu5BtZuSKDJAYmZGUX-HzSw7c4VnoeQgiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMw=ZnR0uVrHUNzNGu5BtZuSKDJAYmZGUX-HzSw7c4VnoeQgiA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_080533_329769_46683CEB 
X-CRM114-Status: GOOD (  30.42  )
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

On Mon, Apr 20, 2026 at 03:22:03PM +0100, Luca Boccassi wrote:
> On Mon, 20 Apr 2026 at 13:26, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sat, Apr 18, 2026 at 05:28:20PM +0100, luca.boccassi@gmail.com wrote:
> > > +}
> > > +
> > > +static const struct dentry_operations luo_session_dentry_operations = {
> > > +     .d_dname        = luo_session_dname,
> > > +};
> > > +
> > > +static int luo_session_init_fs_context(struct fs_context *fc)
> > > +{
> > > +     struct pseudo_fs_context *ctx;
> > > +
> > > +     ctx = init_pseudo(fc, LUO_SESSION_MAGIC);
> >
> > I'd just call that LUO_FS_MAGIC.
> 
> It's specific for the session fd, so I'd rather keep it as-is. Pasha
> what do you think?
> 
> > > +     return 0;
> > > +}
> > > +
> > > +static struct file_system_type luo_session_fs_type = {
> > > +     .name = "luo_session",
> > > +     .init_fs_context = luo_session_init_fs_context,
> > > +     .kill_sb = kill_anon_super,
> > > +};
> > > +
> > >  /* Create a "struct file" for session */
> > >  static int luo_session_getfile(struct luo_session *session, struct file **filep)
> >
> > Luo is going full anti-pattern here. This whole return via a function
> > argument completely messes up the later codepths. We don't do manual
> > get_unused_fd_flags() flags and then file in new code, and then fail
> > in-between:
> 
> This is getting a bit too complex for me and it's all existing stuff,
> so I'll leave it for Pasha and the other maintainers to look at later,
> they are CC'ed
> 
> > >  {
> > > -     char name_buf[128];
> > > +     char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH + 1];
> > >       struct file *file;
> > >
> > >       lockdep_assert_held(&session->mutex);
> > > -     snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
> > > -     file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
> > > -     if (IS_ERR(file))
> > > +
> > > +     ihold(luo_session_inode);
> >
> > Right, you're now sharing the same inode among all luo sessions. So
> > you've gained the ability to recognize luo inodes via fstatfs() but you
> > still can't compare two luo session file descriptors for equality using
> > stat() which is a major win and if you're doing this work anyway, let's
> > just go the extra step.
> 
> I'm not aware of any use case for this, it wasn't even discussed, so
> I'll leave this out for now, if the need comes up it can certainly be
> revisited later. A singleton is nice as it saves some resources.

I've almost written the code for you in my first reply and it's also a
literal 1:1 templated copy from what I already did pidfs as well.

Let's do things right from the start and not taky nasty shortcuts to fix
one minor urge without having any foresight at all. If you want to have
an actual tiny filesystem to identify an inode type do it properly and
add the semantics to allocate separate inodes and get all the goodies at
once and make it possible to maintain this properly.

You will need this for so many other reasons than inode comparison such
as lsm integration which definitely want to end up managing this. None
of this works with a single inode. This is not difficult.

And this cop-out would never fly in systemd. I'm regularly sent through
15 review rounds to implement 5 different approaches to the same
problem. So are you. Please take the code I've given you and simply copy
and paste it over what you already did and solve this correctly once and
for all instead of hacking up a filesystem for a single inode so you can
define an inode type.

