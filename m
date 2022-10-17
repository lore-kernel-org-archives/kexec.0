Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB72C4321E
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pINbhknchMZ3koqWFxYoqGglBM4T3t4vwJ/E5HZPRAA=; b=4zjZBRADaSCsdv
	Q1ELMPUzGIOdNbvjgmFePxbmU/N2B/U4TPA+SKitPLeyFiCHUk6wT2nTIrG5t6Sg5IhshmQ6HWA4t
	Alprx2bQy9tE2aGjjQTLn8RyVK9Ln9fpnKeNhESLDFMepffUvFHoIOIibgjM/hJw6rgJrLnSckqFv
	73LUS5o1mEpTaahvtWpO91FDBWt/W9L0kCVAFu+V6SUGQVTBBkVKMmssLD26RTlWR1T+Dy5mj7LCH
	3w5BQbvKt9crYg5RtFd/7i/lcLrp+YWmIZI/7EOA3TQQVU+7UJseQkP6Xc2p3Zlvr7i8i5BuUyTg7
	r3AlPGG3xkhhOkgvy8LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsTT-008JgR-4t; Fri, 21 Oct 2022 13:54:11 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okR1F-00Ceyj-AE; Mon, 17 Oct 2022 14:23:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9xfL6/k7u4koaszP9KMyOY8wVCMBnHlZFYRYE37DwZY=; b=o281kDXC1NHE1O1sCc6sXM9LPE
	mLG85YE4HpDt2UDR1cx42oNsH8/nYPAlzUVkWE51DdULUUsrQhU39HNcA/p+K+w576wxw35/ljBCA
	oAJ5D+M2I6R1f0OeoZFz1dc/37unXROytiAdKajzm9uTEpMvan310AjwwrKiCLsisNyaiX/JKFC0T
	O7J4aiHOU+KPie0YpoMEzCG1excULa3xLark3GU9tNNF7PBwRs4w4WjVHhJRczPkDFbOngJVd2Cva
	FhHI1pO3mpjqcXkn6Xt/aoyELWmIiKVa0sntcXfg1c92No4PQRjZBQH4GSPR52zDjWtBPw2dsx5mC
	yL6oJufQ==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1okR18-000PGI-VK; Mon, 17 Oct 2022 16:22:58 +0200
Message-ID: <5178691f-3a43-9f19-dcd0-98d3a104afa3@igalia.com>
Date: Mon, 17 Oct 2022 11:22:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 04/11] um: Improve panic notifiers consistency and
 ordering
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-um <linux-um@lists.infradead.org>, kexec <kexec@lists.infradead.org>,
 bhe <bhe@redhat.com>, Petr Mladek <pmladek@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-hyperv <linux-hyperv@vger.kernel.org>, netdev
 <netdev@vger.kernel.org>, x86 <x86@kernel.org>,
 kernel-dev <kernel-dev@igalia.com>, kernel <kernel@gpiccoli.net>,
 halves <halves@canonical.com>, fabiomirmar <fabiomirmar@gmail.com>,
 alejandro j jimenez <alejandro.j.jimenez@oracle.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, bp <bp@alien8.de>,
 Jonathan Corbet <corbet@lwn.net>, d hatayama <d.hatayama@jp.fujitsu.com>,
 dave hansen <dave.hansen@linux.intel.com>, dyoung <dyoung@redhat.com>,
 feng tang <feng.tang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 mikelley <mikelley@microsoft.com>,
 hidehiro kawai ez <hidehiro.kawai.ez@hitachi.com>, jgross <jgross@suse.com>,
 John Ogness <john.ogness@linutronix.de>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@kernel.org>, mhiramat <mhiramat@kernel.org>,
 mingo <mingo@redhat.com>, paulmck <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 senozhatsky <senozhatsky@chromium.org>, stern <stern@rowland.harvard.edu>,
 tglx <tglx@linutronix.de>, vgoyal <vgoyal@redhat.com>,
 vkuznets <vkuznets@redhat.com>, will <will@kernel.org>,
 xuqiang36 <xuqiang36@huawei.com>,
 anton ivanov <anton.ivanov@cambridgegreys.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-5-gpiccoli@igalia.com>
 <1f464f3d-6668-9e05-bcb7-1b419b5373e1@igalia.com>
 <2087154222.237106.1663535981252.JavaMail.zimbra@nod.at>
 <280ce0ae-5a50-626f-930f-2661a109fa36@igalia.com>
 <422015181.40644.1666015829599.JavaMail.zimbra@nod.at>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <422015181.40644.1666015829599.JavaMail.zimbra@nod.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_072305_370956_79EBC2D8 
X-CRM114-Status: UNSURE (   7.54  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 21 Oct 2022 06:53:58 -0700
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMTcvMTAvMjAyMiAxMToxMCwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+IC0tLS0tIFVy
c3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0KPj4gVm9uOiAiR3VpbGhlcm1lIEcuIFBpY2NvbGkiIDxn
cGljY29saUBpZ2FsaWEuY29tPgo+PiBIaSBSaWNoYXJkIC8gSm9oYW5uZXMsIGlzIHRoZXJlIGFu
eSBuZXdzIG9uIHRoaXMgb25lPwo+PiBUaGFua3MgaW4gYWR2YW5jZSwKPiAKPiBJdCdzIHVwc3Ry
ZWFtOgo+IGdpdC5rZXJuZWwub3JnL2xpbnVzLzc1OGRmZGI5MTg1Y2Y5NDE2MGYyMGU4NWJiZTA1
NTgzZTNjZDRmZjQKPiAKPiBUaGFua3MsCj4gLy9yaWNoYXJkCgpXb3csIHRoYW5rcyEgSSBhbSBz
b3JyeSwgSSBkaWRuJ3Qgbm90aWNlLgpDaGVlcnMsCgoKR3VpbGhlcm1lCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
