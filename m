Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07F8CD98D2
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vCAft+wNFzTJkXX3u25v7t+QrQgbH+kLVe959bS8e0s=; b=KPPp9yHYxwlxyUWDHB2VXnbgfQ
	t6oRnBl+Emljd7CyYioLs0xWowz1j9/t32WqwQTrlKenMwmDAD8EYTKd8s9VfJQzTY35XQUXQoWfw
	kkovpy4a4rs5WOMxjoIb7orKKvlB1GQAzRm0B4iEJXm3CIZZxvsncC+1GCtirEV+M8l32LgqRhkLb
	IjCDTZ7ra89ruypqIxydI7ruYYYuhAK/ROVLpQbj/MPvLBUUlQpE6dTccCVKTwpcREz2q93jCP0jh
	d6rzYgE3DGObuNzVbTESBw5nhdWXodW+RCnGXdlI5D9CwINGnr0bOqBYfQiyH8Bko3NRyPy5OHeZf
	IMSUgidw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXbD7-0000000942w-4861;
	Thu, 11 Jun 2026 08:56:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXbD6-0000000942b-3Lng
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 08:56:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B8264048D;
	Thu, 11 Jun 2026 08:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5123F1F00893;
	Thu, 11 Jun 2026 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781168182;
	bh=vCAft+wNFzTJkXX3u25v7t+QrQgbH+kLVe959bS8e0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=aFkrwk5DY58I4i5IyiCBJKN3sva/en/gLvF99Uz0yEr6tURRmA57nCQ2/MYlPvx3a
	 FqnsbdbBc18Zh4JbRMVR6sbnngV5LiZkpCVGReUG0IzT4Lt4QzKoF6iZZfbirEHn+7
	 xe2tgspPtViSX0rYYFDx6T603gfqKr9hFxe9nyNDmNdS32lc97NRacQlAhsONevo5O
	 +PkrIJ4rcAtgV9Smtqnvxch3QyMlCdWO2aJNOC0KY9ZCi1xtJ4z/pelEZrA59QxFuS
	 JOGAxfuuqt93NASp1da5x2kj2gdMyDxGei7sbfRlAbZ0t+80BvQX9Fvan0qEYvzRa2
	 YoRcktZc+pRvw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Vipin Sharma <vipinsh@google.com>
Cc: pasha.tatashin@soleen.com,  rppt@kernel.org,  pratyush@kernel.org,
  tarunsahu@google.com,  skhawaja@google.com,  shuah@kernel.org,
  dmatlack@google.com,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/liveupdate: Add helpers to
 preserve/retrieve FDs
In-Reply-To: <20260610230909.876546-3-vipinsh@google.com> (Vipin Sharma's
	message of "Wed, 10 Jun 2026 16:09:08 -0700")
References: <20260610230909.876546-1-vipinsh@google.com>
	<20260610230909.876546-3-vipinsh@google.com>
Date: Thu, 11 Jun 2026 10:56:18 +0200
Message-ID: <2vxz4ij9sbf1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Jun 10 2026, Vipin Sharma wrote:

> Add helper functions to preserve and retrieve file descriptors from an
> LUO session. This allows library users to work with FD preservation.
>
> Now that there are helpers, use them instead of direct ioctl calls
> in liveupdate.c
>
> No functional change intended.
>
> Co-developed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

