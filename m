Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WOptu-0006WE-8g
 for kexec@lists.infradead.org; Sat, 15 Mar 2014 14:49:26 +0000
Date: Sat, 15 Mar 2014 14:48:55 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v3 4/4] x86: Pass memory range via E820 for kdump
Message-ID: <20140315144855.GG5834@console-pimps.org>
References: <1394464149-30384-1-git-send-email-chaowang@redhat.com>
 <1394464149-30384-5-git-send-email-chaowang@redhat.com>
 <20140313222428.GW7672@oranje.fc.hp.com>
 <20140314024726.GA2245@dhcp-16-126.nay.redhat.com>
 <20140314082615.GE5834@console-pimps.org>
 <20140314202706.GX7672@oranje.fc.hp.com>
 <20140315142625.GA8735@nazgul.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140315142625.GA8735@nazgul.tnic>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: toshi.kani@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, horms@verge.net.au, Linn Crosetto <linn@hp.com>, hpa@zytor.com, Dave Young <dyoung@redhat.com>, trenn@suse.de, WANG Chao <chaowang@redhat.com>, ebiederm@xmission.com

On Sat, 15 Mar, at 03:26:25PM, Borislav Petkov wrote:
> 
> Btw, Matt, your whole efi/next stuff is already in tip, right? Because
> if so, Linn could simply test latest tip/master.

Yep, everything is in tip/master.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
