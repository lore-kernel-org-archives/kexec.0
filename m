Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTQxA-00036T-P6
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 07:11:49 +0000
Date: Fri, 28 Mar 2014 15:12:20 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 2/4] x86: Store memory ranges globally used for crash
 kernel to boot into
Message-ID: <20140328071220.GA1072@dhcp-16-126.nay.redhat.com>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <1395216241-13983-3-git-send-email-chaowang@redhat.com>
 <20140328032438.GD26116@dhcp-16-126.nay.redhat.com>
 <20140328061353.GF2944@dhcp-17-89.nay.redhat.com>
 <20140328064330.GG26116@dhcp-16-126.nay.redhat.com>
 <20140328065121.GH26116@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140328065121.GH26116@dhcp-16-126.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

> > > system ram and crash_reserved together before building EFL header.
> > 
> > There's already below code which ignore the ram ranges..
> >         for (i = 0; i < ranges; i++, range++) {
> > 		if (range->type != RANGE_RAM)
> > 			continue;
> 
> Hmm, this RANGE_RAM is converted from Crash Kernel ranges. so for what I suggested it need change
> to != RANGE_CRASH_KERNEL

They are the 1st kernel RANGE_RAM ranges, please ignore above reply, I confused myself :(

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
