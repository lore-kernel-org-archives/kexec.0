Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WONRz-0003p3-NH
 for kexec@lists.infradead.org; Fri, 14 Mar 2014 08:26:44 +0000
Date: Fri, 14 Mar 2014 08:26:15 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v3 4/4] x86: Pass memory range via E820 for kdump
Message-ID: <20140314082615.GE5834@console-pimps.org>
References: <1394464149-30384-1-git-send-email-chaowang@redhat.com>
 <1394464149-30384-5-git-send-email-chaowang@redhat.com>
 <20140313222428.GW7672@oranje.fc.hp.com>
 <20140314024726.GA2245@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140314024726.GA2245@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: toshi.kani@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, horms@verge.net.au, bp@alien8.de, Linn Crosetto <linn@hp.com>, hpa@zytor.com, trenn@suse.de, WANG Chao <chaowang@redhat.com>, ebiederm@xmission.com

On Fri, 14 Mar, at 10:47:26AM, Dave Young wrote:
> 
> Can you test with matt's tree to see if it works?
> If it still happens please post the full log.

So that'd be the 'next' branch at,

  git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/efi.git

which contains Borislav's fixes for the EFI memmap code.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
