Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g6t0185.atlanta.hp.com ([15.193.32.62])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKPY1-0006aa-DH
 for kexec@lists.infradead.org; Fri, 13 Sep 2013 09:20:20 +0000
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
 by g6t0185.atlanta.hp.com (Postfix) with ESMTP id BF8B0241FE
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 09:19:52 +0000 (UTC)
Received: from [16.51.181.81] (swa01lbdc1025-026-vl250-snat3.atlanta.hp.com
 [16.228.13.93])
 by g5t0030.atlanta.hp.com (Postfix) with ESMTP id 64DAB140B3
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 09:19:52 +0000 (UTC)
Message-ID: <5232D8AC.5080704@hp.com>
Date: Fri, 13 Sep 2013 12:19:40 +0300
From: Bogdan <bogdan.oprea@hp.com>
MIME-Version: 1.0
Subject: Hardware state when jumping
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
To: kexec@lists.infradead.org

Hello,

I am provisioning servers with linux using kexec on Proliant servers 
usualy gen 8). The basic steps are as folow:
     1. Boot in a Service OS (Rhel or Sles)
     2. Make some configurations
     3. Jump to OS Installer kernel and install specific OS
     4. Reboot (after reboot the server is ready for production)

My question is regarding hardware state of the server when jumping.

     - Is there any version of kexec that handles hardware state 
especialy for Proliant hardware, and if not, are there any alternatives?

Thank you for you time,
Bogdan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
