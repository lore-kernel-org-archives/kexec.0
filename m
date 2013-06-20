Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UpSKe-0008SO-U3
 for kexec@lists.infradead.org; Thu, 20 Jun 2013 00:02:35 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 81DA03EE0BB
 for <kexec@lists.infradead.org>; Thu, 20 Jun 2013 09:02:02 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7405F45DE56
 for <kexec@lists.infradead.org>; Thu, 20 Jun 2013 09:02:02 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5B32B45DE55
 for <kexec@lists.infradead.org>; Thu, 20 Jun 2013 09:02:02 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4EDCB1DB8049
 for <kexec@lists.infradead.org>; Thu, 20 Jun 2013 09:02:02 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 079841DB8048
 for <kexec@lists.infradead.org>; Thu, 20 Jun 2013 09:02:02 +0900 (JST)
Message-ID: <51C24656.1080509@jp.fujitsu.com>
Date: Thu, 20 Jun 2013 09:01:26 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: add missing options to man page or help
References: <fc047066a6f5ba18f02838f4b3e89006917db4a5.1371632010.git.bhe@redhat.com>
In-Reply-To: <fc047066a6f5ba18f02838f4b3e89006917db4a5.1371632010.git.bhe@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

(2013/06/19 17:55), Baoquan He wrote:
> makedumpfile has some options which has two 2 forms, long option
> and short option. E.g. --help  |  -h
>
> In man page and help, only one of them are presented, user may complain
> of this. Here add missing options.
>

I guess the maintainer does so intentionally, I'm not sure of course. Characters for short options is limited resource, but now makedumpfile has considerably many options. We can no longer assign reasonable letters to each functionality with short options. For example, please look at the definition of longopts:

static struct option longopts[] = {
         {"split", no_argument, NULL, 's'},
         {"reassemble", no_argument, NULL, 'r'},
         {"xen-syms", required_argument, NULL, 'y'},
         {"xen-vmcoreinfo", required_argument, NULL, 'z'},
         {"xen_phys_start", required_argument, NULL, 'P'},
         {"message-level", required_argument, NULL, 'm'},
         {"vtop", required_argument, NULL, 'V'},
         {"dump-dmesg", no_argument, NULL, 'M'},
         {"config", required_argument, NULL, 'C'},
         {"help", no_argument, NULL, 'h'},
         {"diskset", required_argument, NULL, 'k'},
         {"non-cyclic", no_argument, NULL, 'Y'},
         {"cyclic-buffer", required_argument, NULL, 'Z'},
         {"eppic", required_argument, NULL, 'S'},
         {"map-size", required_argument, NULL, 'A'},
         {0, 0, 0, 0}
};

I don't see any relationship on the last three options: non-cyclic vs Y, cyclic-buffer vs Z, eppic vs S and map-size vs A. I don't think there are users who use short options for these features.

One of my solution is conversely to delete short options, and I don't think it problem because the short options are only implicitly exported without explicit description on such as manual page and help message.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
