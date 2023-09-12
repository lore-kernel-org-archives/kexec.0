Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA589EE3F10
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 19:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FcDePkB9/O7aMDKzX1RXQz2hA7ndEB4cfzYMfGYsP8A=; b=wUPhKmneozSSEq
	LwG9k9bKY0qRTMXfc2JXCYrRFFsvVMf4cfMDrdihvRbk2l1wCGH6VVEbGDoIZWBJyhk4BQjrk4PkW
	eC5dJPz7jwCgOAwCUKRdawZOV5tTPrigW71XIH9hgas725/IFY+F+rat0hpts+7+jgovBHyz8EvOy
	BsLffxck0GZc/Z+eP4MPqgRTn4qI6K9Vc+JIujrVRHZjxMEoS2W3+cA8/5WfSFQUsjFmje1w6hbTU
	Y64mxs9sr7GyUB0MDPGUxpelbavA2nIjOpScpeg6/OC3frd+/NrFyR+NUG7aGLC74Q6vXbXgeRnLh
	YesxYmWYLSzXgJw2xLIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg91E-0042bH-2Q;
	Tue, 12 Sep 2023 19:25:52 +0000
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg91C-0042as-2F
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 19:25:52 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id BA6703200956;
	Tue, 12 Sep 2023 15:25:48 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 12 Sep 2023 15:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1694546748; x=1694633148; bh=BE
	7ZXCk/MgLEHu3BSEJ2Y4XEXWqdUk+ZioNphLesHsw=; b=UDK3s7zu7EHyZsX2vX
	xqiLdTCWRefqAkBTHumQBvPbQkZjroWSZ0ngXVjXozeSH/zFdd380QoEWR4QnK7U
	f7504j75XUfMBIB+U3M2MVC4ljvq9Hyad4R0cFMM6wgAZ57VX6NLaV9VduXu4EdQ
	rgQDze29GljtyiQx0o+4AtGzhf0gXJ8L7Qm91fow0xVoXBjGFz57eKbM6412xclK
	zzdpFeZyi4xquBvJrcLAmzEPSN8mR0x4/iIYt9OVWcbIFSwsekTVbvcY2nrnmEIv
	GA1nlA/hCJqp1IAdg1r3xCJFJzlts7EFoWuW3un7BtfyZ7k7AcG+fuPB/E1EpHau
	vS7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1694546748; x=1694633148; bh=BE7ZXCk/MgLEH
	u3BSEJ2Y4XEXWqdUk+ZioNphLesHsw=; b=WJqa+DcAYYxqkqAHnCPQL/MFgJImg
	tM5pbmtr+rNbi77so+6ipb7ZwZCW9vAUKQaMYQXjcZvoI9tl2QVrRzu1YyG4wE9A
	P5X3yPJ5i6SoaTw3oo9Qsgj5rPNlItBg20KLzS2JEZuwPEn2F7kL5p/qZIArA4Z5
	8muY65Vr/pR5qkAo0ackeHoL47tbPanR7D/hML+6IRwy9BQAombG1QdPxH95HrCf
	90Z0eJcAf3lPtTkf7SJPJp9XNVbZ8vnB8sI9DVgfSvnuRayn6htRMfZnjW87vNeb
	a8+uXviIBRE8IrDQBOh7+Z8nECSt57frLfevEsVYOqgIj27y4KMxuXIDw==
X-ME-Sender: <xms:O7sAZTWp7IhGHfdd6sg5zODCBTeRSVsM3Aj1b9BqNcyNtIjoI5d9Iw>
    <xme:O7sAZbnFmydoMpUyUU2caSJ33qu_A7XCtXXFi5ti0hQCZjrB4QYlMEzOpe6uiEKke
    Qh-1TTCIsYOn5jZp8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepofgfggfkjghffffhvfevufgtsehttder
    tderredtnecuhfhrohhmpedflfgrnhcujfgvnhgurhhikhcuhfgrrhhrfdcuoehkvghrnh
    gvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpedujefhffdvffeikedvkeef
    ieeutdffteelgeetfffhkeffheeiheehvedtheetieenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhgvrhhnvghlsehjfhgrrhhrrdgttg
X-ME-Proxy: <xmx:O7sAZfa943x7N0B5bxibdM_v7XlESBQq6IIlrDja8WI83DZGzex_VA>
    <xmx:O7sAZeVRToFt1MFB1LLYm_sFogZmf14F3YZHfcDqiew_YCIR4PESfA>
    <xmx:O7sAZdlgTL2J9JTIyjSVmoM9XbSJZagPiqnUal1wmsq1-QgYH3IuHg>
    <xmx:PLsAZWfb4Hv1plzRqnMrCQd0HGpyIRP-TwnINI7WWEIh1WywccHpiQ>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B96D815A0091; Tue, 12 Sep 2023 15:25:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <204f124d-c79d-4ad6-8f69-b7bb5f8d1ab6@app.fastmail.com>
In-Reply-To: <ZP+41JvEFjsnEG19@MiWiFi-R3L-srv>
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <ZP+41JvEFjsnEG19@MiWiFi-R3L-srv>
Date: Tue, 12 Sep 2023 21:25:26 +0200
From: "Jan Hendrik Farr" <kernel@jfarr.cc>
To: "Baoquan He" <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 tglx@linutronix.de, dhowells@redhat.com, vgoyal@redhat.com,
 keyrings@vger.kernel.org, akpm@linux-foundation.org, bhelgaas@google.com,
 "Luca Boccassi" <bluca@debian.org>, lennart@poettering.net, prudo@redhat.com
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_122550_766590_629AB967 
X-CRM114-Status: GOOD (  10.07  )
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

> By the way, could you provide detailed steps about how to test this
> patchset so that people interested can give it a shot?

Sure.

0. Build and run your kernel with my patches.
1. You're gonna need a UKI to kexec. I personally use sbctl or ukify to create them.

sbctl command example (assumes you have the cmdline you want saved in a file called cmdline):
sudo sbctl bundle -k /boot/vmlinuz-6.5.2 -f /boot/initrd.img-6.5.2 -c ./cmdline -s ./uki.efi

ukify command example:
sudo python3 ukify.py build --linux=/boot/vmlinuz-6.5.2 --initrd=/boot/initrd.img-6.5.2 --cmdline <cmdline as string or a filename>

2. If you are running in lockdown mode you'll have to sign the UKI. You can use sbctl, pesign, or sbsign for example.
3. Compile kexec-test (see links below). Simple "gcc main.c -o kexec-test" should work
4. Do the kexec load: ./kexec-text <path to uki>
(this is equivalent to "kexec -a -l <path to UKI>", however that currently complains about not recognizing the format)
5. At this point it's useful to check if the loading succeeded with: "cat /sys/kernel/kexec_loaded" (should return "1")
6. Do a kexec reboot. If you are running systemd, the best way is with: "systemctl kexec". Otherwise you can try "kexec -e", however this will not shut all your services down

If anyone has problems please feel free to ask.

Links:
sbctl: https://github.com/Foxboron/sbctl
ukify: https://github.com/systemd/systemd/tree/main/src/ukify
kexec-test: https://github.com/Cydox/kexec-test/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
