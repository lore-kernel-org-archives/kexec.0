Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FD3C02183
	for <kexec@archiver.kernel.org>; Fri, 17 Jan 2025 07:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E1LQIE7A3BgeZ+4yFDmM8zl4yAhscW3P2uZTCe0E7QQ=; b=F3Rd6igTegLRmEqCPHPUTGCDXR
	XaarEt75szvpa7J0Fb+Jw+c2h5rbLHzIaLalQMsZgnYl5+uE2MgI+DhpymDw6JPvOTUG9cLeS3a2l
	RF4wEaqsnN5VPoormAMRQ2uj8yw2+pYw8HVJMKhCPlXib37h8s6GGxzJumnTGnbd3d6ouE0FGosQK
	JbUOQz499BRaycFh5JuTNHuXIcYr+65ONBiz4Rj5bzsknP1iOGDW76qhV1HA5ijG8B7rbbwm61IiK
	k0beextglvzc7uUXrwama+oBI+yw0r5zn4sx6jCeRV2ieUMTid+2qc9SbO3al/vD4zBA3hY35SKk1
	+I6iRVkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYh9m-0000000HFjk-0BXP;
	Fri, 17 Jan 2025 07:52:42 +0000
Received: from out-183.mta0.migadu.com ([2001:41d0:1004:224b::b7])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYh9g-0000000HFit-0gS6
	for kexec@lists.infradead.org;
	Fri, 17 Jan 2025 07:52:38 +0000
Date: Fri, 17 Jan 2025 08:52:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1737100347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1LQIE7A3BgeZ+4yFDmM8zl4yAhscW3P2uZTCe0E7QQ=;
	b=KCBHr6PpbeKy+Ngi4T06ug2ZvbfATktuu3JnlVaBVNoIkHgi7IOqZwbgYQBny79GEfWKJA
	zfI046qs2mMrfgHHn4MyrDnNVN85Wkk8Ig1ezp3UQuf5hBqn0sfaOY3mnQBbyL8f4pbL6b
	bnpU3jCMDSRzS2QJzrvb5SsASz2WWbBIF3rXKEeifiNt4RskNO4uUX4gRW9IsOtcZT+pVB
	q46aioIDLKdPxZu7A/t5bJYlzvhe4gPIopELEGyffLbJZ/bbJphADZZJ8L8nxOG+U3ISui
	B2POw8E5xEARl6/cfEs/fveS1aMFX2903rV12KyANd1E4K0Yd9RFus9/Bj/ESw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Baoquan He <bhe@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com,
 rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
 kexec@lists.infradead.org, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BREGRESSION=5D_Kernel_booted_via_k?=
 =?US-ASCII?Q?exec_fails_to_resume_from_hibernation?=
In-Reply-To: <Z4nRWnysvuxLWU32@MiWiFi-R3L-srv>
References: <Z4WFjBVHpndct7br@desktop0a> <Z4Zjmva-pLbLjtQv@desktop0a> <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv> <Z4ejbdJr87V3IwV8@desktop0a> <Z4jy-NoLxpwaLfyD@desktop0a> <Z4m4q8yfIjfMRgZ+@MiWiFi-R3L-srv> <Z4nRWnysvuxLWU32@MiWiFi-R3L-srv>
Message-ID: <1A927798-F31C-49EE-8CE9-657FA6E72842@r-ricci.it>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_235236_765488_ABBB5DCF 
X-CRM114-Status: UNSURE (   8.24  )
X-CRM114-Notice: Please train this message.
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

On 17 January 2025 04:41:14 CET, Baoquan He <bhe@redhat=2Ecom> wrote:
>On 01/17/25 at 09:55am, Baoquan He wrote:
>> On 01/16/25 at 12:52pm, Roberto Ricci wrote:
>> > On 2025-01-15 Wed 13:00:52 +0100, Roberto Ricci wrote:
>> > > On 2025-01-15 Wed 12:04:10 +0800, Baoquan He wrote:
>> > > > On 01/14/25 at 02:16pm, Roberto Ricci wrote:
>> > > > > On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
>> =2E=2E=2Esnip=2E=2E=2E
>> > Also, I can't reproduce with the default config (make defconfig),
>> > therefore something in my config (I already sent it) may play a role=
=2E
>>=20
>> What I tried is defconfig on 6=2E13-rc7, let me try your config again=
=2E
>
>I tried your config on the latest kernel, reboot will fail during the
>new kernel bootup after newly built kernel was installed=2E
>
>I haven't compared your config with the defconfig to see their
>difference=2E Wondering where your config comes from=2E
>

(Re-sending as I forgot to add CC, sorry)

It's based on the config used by my distribution:
https://raw=2Egithubusercontent=2Ecom/void-linux/void-packages/41335626868=
0b477b42a4af9462b9bb49491ca19/srcpkgs/linux6=2E12/files/x86_64-dotconfig
I ran `make olddefconfig` and `make localmodconfig`, then
I made a few changes in nconfig, such as enabling KASAN
and UBSAN=2E

The kernels provided by the distribution, which have very
minimal patches, are affected as well=2E

