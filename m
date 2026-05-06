Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7452ACD3439
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 21:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=enQWhg6QtmVPkhQqID7Zl415vjJPeJyWdjw4unLNDAY=; b=PX6VWgNEf0tKDIiqHq57cS4SIz
	bOz9B2HGiLpma3UmXcQC4Rd5WSy0JZ/qN8WuWkVmRXXP+KU7DLifSzUIPP0yQyArktGcbBNhuFH5J
	X2fANHFNcSSW3TFstCQmjBH3jJvJNDfrvTwx3QTnlCIH/eO1fauxyBstcYafufcQLDJm8lTZZFgNd
	iF0Lns8Urc9IBKascYlbMwmpZzAiRYWotFVxSbj7L3pxMmNXTuKHbmGkWxWHx8yofA7W2E4xXCSxG
	YkvpHcil78fsLyOldkFjtCl0b+5xYtef4izdmSGsFDphIMpHvk8UkheDje3+Z02CUAlJis/hHFJRy
	TYVHxZBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKjjo-0000000260V-0Uts;
	Wed, 06 May 2026 21:25:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKjjm-0000000260K-394G
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 21:24:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CDF3D6013B;
	Wed,  6 May 2026 21:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63937C2BCB0;
	Wed,  6 May 2026 21:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778102697;
	bh=XyPxJfPyf0GdPyGr96MwQqjICS2aXF/AB6T7qNKrr/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N6v0d4sHE8VSxC7zqCPU8NvyAVWyDGStGcQnoBbIYY/vKFrk6WWUlIxHmpnRdEA/V
	 +poSMbxdBaPJy2dg8IIYv4WmkKYp9Ttib05o9yudzRJE8g0a256xWfqqRUcwDqGe3O
	 ucClFN+6obVGZThlSsczy23T2ML9VhtxaG+c0D1yb8Is36jmYbuggq5P3f5gkXj902
	 pbkTW/LIUk3SdssbTNQQ4E1lGYBwwUtowyNxFff/G7y10PhhKkMYM+wXKd7PuIybaX
	 rdS+3yGXD0cKFtY7KQ+m1bNF5rURA5i6oBY3wjxo/LVjqc1u3qL3lV/PqxXjHbY6hQ
	 +QkcVfbIH8oLA==
Date: Wed, 6 May 2026 16:24:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Jeffery <djeffery@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Tarun Sahu <tarunsahu@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	=?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
	Jordan Richards <jordanrichards@google.com>,
	Ewan Milne <emilne@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	"Lombardi, Maurizio" <mlombard@redhat.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Laurence Oberman <loberman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>, kexec@lists.infradead.org,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 4/5] PCI: Enable async shutdown support
Message-ID: <20260506212456.GA880761@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-xHTFj_J4r2oqG8cPOU_wx7pChjHt9SgyHzKbTD8+KgeSFXw@mail.gmail.com>
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

On Wed, May 06, 2026 at 05:10:19PM -0400, David Jeffery wrote:
> On Wed, May 6, 2026 at 2:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Apr 29, 2026 at 01:50:15PM -0400, David Jeffery wrote:
> > > Like its async suspend support, allow PCI device shutdown to be performed
> > > asynchronously to reduce shutdown time.
> > >
> > > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > > Tested-by: Laurence Oberman <loberman@redhat.com>
> > > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> > Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > I'm concerned about tripping over driver issues, but it's a pretty big
> > benefit.  I think it's worth mentioning the "async_shutdown" module
> > parameter somewhere in the commit logs and putting an example in
> > Documentation/admin-guide/kernel-parameters.txt.
> 
> Sure, I can see about adding a document patch to it.
> 
> > Might even consider keeping in -next for a cycle+ and targeting v7.3.
> 
> I would be happy for it to spend as much time in linux-next as needed
> for people to be comfortable with the risk of odd interactions with
> all the pci drivers it will indirectly impact.
> 
> But I must admit my ignorance with some of the details of linux-next.
> Looking at the main code changes, the patchset would seem to want to
> go through driver-core to get to linux-next. But as far as indirect
> impact, it is the diverse collection of devices and drivers under PCI
> which are most affected by the changes. Is there a consensus on how to
> steward a patchset like this one into linux-next?

My guess is it should all go via the driver-core tree, given acks or
reviewed-by from the other subsystems it touches.

