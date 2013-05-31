Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UiMr5-000692-3Q
 for kexec@lists.infradead.org; Fri, 31 May 2013 10:46:44 +0000
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Fri, 31 May 2013 20:32:48 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B7E2A2CE8023
 for <kexec@lists.infradead.org>; Fri, 31 May 2013 20:46:08 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4VAVmTP21889096
 for <kexec@lists.infradead.org>; Fri, 31 May 2013 20:31:49 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4VAk7tE006832
 for <kexec@lists.infradead.org>; Fri, 31 May 2013 20:46:07 +1000
Message-ID: <51A87F6A.6090407@linux.vnet.ibm.com>
Date: Fri, 31 May 2013 16:16:02 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: makedumpfile security key filtering with EPPIC scripts
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Tachibana <tachibana@mxm.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, ananth@in.ibm.com, BUENDGEN@de.ibm.com

Hi Atsushi/Tachibana,

Now that upstream makedumpfile has eppic support, we are working
on sample EPPIC scripts that can be used with makedumpfile to scrub
confidential data from the vmcore. With these sample scripts as a
reference, customers can come up with their own EPPIC scripts. We are
looking for the possibility of pushing these sample EPPIC scripts to
upstream makedumpfile. Please let me know your opinion on this.

Regards,
Aruna


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
