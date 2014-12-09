Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.180.65] helo=relay.sgi.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XySto-0001L0-IK
 for kexec@lists.infradead.org; Tue, 09 Dec 2014 22:04:53 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
 by relay2.corp.sgi.com (Postfix) with ESMTP id 7C35030404E
 for <kexec@lists.infradead.org>; Tue,  9 Dec 2014 14:04:27 -0800 (PST)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
 by estes.americas.sgi.com (Postfix) with ESMTP id CEE8C700350C
 for <kexec@lists.infradead.org>; Tue,  9 Dec 2014 16:04:27 -0600 (CST)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.76)
 (envelope-from <cpw@sgi.com>) id 1XyStP-0004rK-LJ
 for kexec@lists.infradead.org; Tue, 09 Dec 2014 16:04:27 -0600
Date: Tue, 9 Dec 2014 16:04:27 -0600
From: Cliff Wickman <cpw@sgi.com>
Subject: [PATCH 0/2] time and space saving patches for large memories
Message-ID: <20141209220427.GA18652@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org

From: Cliff Wickman <cpw@sgi.com>

Back in early 2014 I submitted several patches for your consideration, most of
which concerned saving time and disk space when dumping very large memories.

I offer two of them again, as being the most important elements for the
practical dumping of very large memories.

[PATCH 1/2] use raw i/o and root device to use less memory
[PATCH 2/2] exclude page structures of non-dumped pages
  The second patch has a few dependencies on the first. But they are logically
  separate.  
  They apply to the 1.5.7 source.

As an example of the importance of these two concepts:
 We dump a 2TB system using crashkernel=450M.
 Without the patches we write a 3.6G dump in about 12 minutes.
 With the patches we write a 590M dump in about 4 minutes.
And the savings multiply as memory size grows.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
