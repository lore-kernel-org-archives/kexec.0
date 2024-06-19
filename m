Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA5AC27C53
	for <kexec@archiver.kernel.org>; Wed, 19 Jun 2024 12:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xAYDF4qLL6sqccPreY+xOJjtl1n+LQJ95l5VhPbYju4=; b=OjZeGx6Q5yaWee
	Z9D89FK3fD72w37JS3rFfsHVxkfH2vsFO6rJHwDSoItfTmtsETL1AwkcQBcO1/0BAqMB/RmNgwn9Y
	3SZC/LoduxHWYSC+zyx8B6pp/oUMXRsR396i9CLdN8HzNm1qIAEVN2kyaLdVE/QYFk9jBLS09pnIb
	tnjtEiObtHF1Z0ctotcLllzV6bkNYIKYumGzbgP90T9SdTt2FhVvLyKsfz8BxiG5xjJf98i3jn6K6
	Nf77K5F9fS4f4WVSNwQgXFv02P4LHkoLwzCs3qhtVePzMHCUcGzGaw0tfZjzkhC28VUfrH/3TDRve
	sFqFR2S8CMgTq8t9PzkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJu32-000000015lg-2Lcr;
	Wed, 19 Jun 2024 12:04:20 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJu2v-000000015ke-46f9
	for kexec@lists.infradead.org;
	Wed, 19 Jun 2024 12:04:19 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id B335421A95
	for <kexec@lists.infradead.org>; Wed, 19 Jun 2024 12:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718798649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=vFHoQEIfmLnmXQBYbp3q+T/7A7TS6sCPpJv3XLxUSpg=;
	b=jmw0ubQMD8xM6ZW+gzvellGsNJr8X4O3elkiIhXpFmOiw4KPH9SIRWmnaA89V7+69CeEgG
	wfNoW4mHLrXwxWH3uLKI97rs27n6y27YJX208gJY49wh74dPYpIbbKBshOOZxQFkcLKcDU
	DSNyFv0Br+J5yuB5hImV82jxEwokwNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718798649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=vFHoQEIfmLnmXQBYbp3q+T/7A7TS6sCPpJv3XLxUSpg=;
	b=TPYLucD5K0StAgD1UjA8TqsOw0opuus4FPEINQSncBfTxe2Q2HfKqGiFsLcJ5TegqqIPZd
	cCowJqjPiAtPoUAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718798649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=vFHoQEIfmLnmXQBYbp3q+T/7A7TS6sCPpJv3XLxUSpg=;
	b=jmw0ubQMD8xM6ZW+gzvellGsNJr8X4O3elkiIhXpFmOiw4KPH9SIRWmnaA89V7+69CeEgG
	wfNoW4mHLrXwxWH3uLKI97rs27n6y27YJX208gJY49wh74dPYpIbbKBshOOZxQFkcLKcDU
	DSNyFv0Br+J5yuB5hImV82jxEwokwNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718798649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=vFHoQEIfmLnmXQBYbp3q+T/7A7TS6sCPpJv3XLxUSpg=;
	b=TPYLucD5K0StAgD1UjA8TqsOw0opuus4FPEINQSncBfTxe2Q2HfKqGiFsLcJ5TegqqIPZd
	cCowJqjPiAtPoUAw==
Date: Wed, 19 Jun 2024 14:04:09 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: kexec@lists.infradead.org
Subject: [PATCH] makedumpfile: make reserve_diskspace do nothing for
 flattened format
Message-ID: <ZnLJOTWFM5P1PTMf@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-4.08 / 50.00];
	BAYES_HAM(-2.82)[99.22%];
	NEURAL_HAM_LONG(-0.97)[-0.967];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:helo,suse.cz:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_050414_199939_7947B34A 
X-CRM114-Status: GOOD (  10.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

makedumpfile: make reserve_diskspace do nothing for flattened format

reserve_diskspace() is called by write_elf_header() to make sure there is
always space to write the program header, even if writing other data fails
because of ENOSPC.

This is harmful when writing the flattened format to STDOUT for two reasons:

First, it actually wastes disk space, because first the block of zeroes is sent
to STDOUT by reserve_diskspace() and then the actual program header is sent,
meant to overwrite the zeroes when the flattened format is rearranged.

Second, the algorithm used to read flattened format directly by the crash
program does not cope with the flattened file containing two chunks meant for
the same offset. It uses a binary search on a sorted array of flat_data headers
to find the data in the flat file. It may return the zeroed chunk written by
reserve_diskspace() near the beginning of the file instead of the actual ELF
header located near the end of the flattened file.

Fixes: e39216fce9f73759509ec158e39c289e6c211125 ("Make the incomplete dumpfile generated by ENOSPC error analyzable.")
Signed-off-by: Jiri Bohac <jbohac@suse.cz>

---
 makedumpfile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index cadc596..9624c3f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -5206,6 +5206,9 @@ reserve_diskspace(int fd, off_t start_offset, off_t end_offset, char *file_name)
 
 	int ret = FALSE;
 
+	if (info->flag_flatten)
+		return TRUE;
+
 	assert(start_offset < end_offset);
 	buf_size = end_offset - start_offset;
 
-- 
2.43.0

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
