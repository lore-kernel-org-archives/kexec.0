Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400071.outbound.protection.outlook.com
 ([40.107.140.71] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7XdB-0007LY-HX
 for kexec@lists.infradead.org; Thu, 04 Feb 2021 05:56:44 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH 3/3] arm64: support flipped VA and 52-bit kernel VA
Date: Thu, 4 Feb 2021 05:56:28 +0000
Message-ID: <OSBPR01MB1991ECD05F627F153E8651CCDDB39@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <1611888025-29321-1-git-send-email-kazuhito.hagio@gmail.com>
 <1611888025-29321-4-git-send-email-kazuhito.hagio@gmail.com>
 <c8d8d23b-0686-d5e6-f789-aa01ffdfd833@redhat.com>
In-Reply-To: <c8d8d23b-0686-d5e6-f789-aa01ffdfd833@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: piliu <piliu@redhat.com>, "kazuhito.hagio@gmail.com" <kazuhito.hagio@gmail.com>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Pingfan, Bhupesh,

-----Original Message-----
> Except an correction in notes, the rest looks good to me.
> 
> Reviewed-by: Pingfan Liu <piliu@redhat.com>

Thank you for reviewing and testing this, applied the patch set.
https://github.com/makedumpfile/makedumpfile/compare/7f185d2...a0216b6

Bhupesh, thank you for your long term efforts.  I had to drop a few of
your ideas mainly to maintain its functionality and compatibility, but
the basis of your patch was very helpful.

Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
