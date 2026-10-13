Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78127CC6B03
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lwnXpQs8h0RkpXoBgKrIw7VtMxZRGTucGgOpbdPBGLo=; b=g/79aBO++pieYCZTyg85VHZP5I
	I0kawU9iV2CGaqS8shGLEqFy5P5/s1c+0uqYDU1sm/UUzNUatyCP/6gKgoIfOVNhDXa+Ri4fDT6Mp
	aMj61fHAOS9g46EtGUi9uXsnlwQR5zx6OZ/ISKJ7wvRTRfzbGwKHqToDaZ6ONmPLikxlcFEfAuG6B
	yUDtvHhnk9nR3eM97Dutd5uCxmbHjV7kp0cnEiUhXd1fQ0deYF1NqyripYwoTd/LbZxcprzSA99NZ
	tlf+ibaRKuIgwHQMe6DGbUshTU5DUYCw648nc4ung+eaSxHHkwtt+A0L1B45F1ajUhvK4COIOmuPQ
	arOMB3sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGaHV-0000000CetU-1heZ;
	Tue, 13 Oct 2026 11:02:53 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGaHS-0000000Cere-3IuQ
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 11:02:53 +0000
X-UUID: 9b23fc3ac6f511f19a56ed5b684f684d-20261013
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:6db9e078-1538-4d08-8ef9-9329f447ff6b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:597e9dc93505a2ad45b7ff19eaf9495b,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|850|865|898,TC:nil,Content:0|1
	5|50|99,EDM:-3|-100,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9b23fc3ac6f511f19a56ed5b684f684d-20261013
X-User: duanchenghao@kylinos.cn
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 675544311; Tue, 13 Oct 2026 19:02:39 +0800
Date: Tue, 13 Oct 2026 19:02:37 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: jianghaoran@kylinos.cn, avagin@gmail.com, linux-mm@kvack.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: Re: Question about obtaining LUO session FD for non-systemd-managed
 service
Message-ID: <20261013110237.GA836401@chenghao-pc>
References: <6ac99eb9.6b935c14.1905ce.7c50SMTPIN_ADDED_MISSING@mx.google.com>
 <CAMw=ZnTTUxO2ZCobEDTQUY7OZxmyJUQxg4DkhC9gTWXaDaK1dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMw=ZnTTUxO2ZCobEDTQUY7OZxmyJUQxg4DkhC9gTWXaDaK1dQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_040251_154204_6FF80100 
X-CRM114-Status: GOOD (  27.40  )
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

On Sat, Oct 10, 2026 at 03:05:40PM +0200, Luca Boccassi wrote:
> On Sat, 10 Oct 2026 at 04:11, Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > Hi Luca,
> >
> > I watched your excellent presentation from the LPC conference in Prague.
> >
> > I have a question I’d like to consult with you.
> >
> > I am currently working on the `memfd_luo` feature in CRIU. My goal is to
> > leverage the LUO capability to store checkpoint images inside memfds.
> > After a kexec reboot, the image data will be retrieved directly from
> > memory instead of from disk.
> >
> > Here is my pull request on the CRIU GitHub repository:
> > https://github.com/checkpoint-restore/criu/pull/3152
> >
> > In the PR discussion, avagin suggested using systemd as the CRIU daemon
> > to centrally manage LUO sessions and access to `/dev/liveupdate`. I have
> > watched your talk and read parts of the systemd source code.
> >
> > From my understanding, systemd currently provides a unit‑based solution
> > where child processes can inherit LUO session file descriptors. However,
> > this approach requires the target service to run as a child of a systemd
> > unit. As far as I know, CRIU does not run as a systemd‑managed service.
> >
> > So my question is: for services such as CRIU that are **not systemd‑managed
> > child services**, how can they obtain LUO‑session‑related file descriptors
> > managed by systemd?
> >
> > Thank you very much for reading this email. My knowledge of systemd is still
> > limited, so please feel free to correct me if I have misunderstood anything.
> >
> > Thanks & best regards,
> > Chenghao Duan <duanchenghao@kylinos.cn>
> 
> Hi,
> 
> At some point up in the stack, everything runs as a systemd unit, so
> it's only a question of figuring out in your setup how to pass the
> FD(s) up and down the stack.

Hi Luca,

Thanks for your reply.

The `LUOSession=` configuration only takes effect for services managed
by the system manager. If I run the CRIU command from an SSH login shell
as I am doing now, the environment belongs to a transient unit under the
user manager. In this case, we cannot use `LUOSession=` to obtain the
LUO session fd via systemd. Does this mean the process needs to open
`/dev/liveupdate` by itself to create the session fd?

Below is the attached service of the process found via `systemctl status`.

[root@localhost criu]# ps -ef |grep criu
root       57589    7729  0 18:25 pts/2    00:00:00 ./criu/criu dump -D ../test -t 52922 -j --memfd-images -v4
root       57784    7571  0 18:27 pts/0    00:00:00 grep --color=auto criu
[root@localhost criu]# systemctl status 57589
● session-5.scope - Session 5 of User root
     Loaded: loaded (/run/systemd/transient/session-5.scope; transient)
  Transient: yes
     Active: active (running) since Tue 2026-10-13 10:03:55 CST; 8h ago
      Tasks: 4
     Memory: 148.9M (peak: 1.3G)
        CPU: 47.000s
     CGroup: /user.slice/user-0.slice/session-5.scope
             ├─ 7712 "sshd: root [priv]"
             ├─ 7724 "sshd: root@pts/2"
             ├─ 7729 -bash
             └─57589 ./criu/criu dump -D ../test -t 52922 -j --memfd-images -v4

I'm not sure whether my understanding is correct. Could you please
provide your feedback?


BRs
Chenghao

