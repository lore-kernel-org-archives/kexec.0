Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Lutg3-0000GJ-IT
	for kexec@lists.infradead.org; Fri, 17 Apr 2009 19:24:54 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n3HJOeOQ012472
	for <kexec@lists.infradead.org>; Fri, 17 Apr 2009 15:24:40 -0400
Date: Fri, 17 Apr 2009 15:24:38 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <123826343.4880961239996278674.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <884741448.4880661239996117339.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: makedumpfile question / request
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>
Cc: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>


Is there a reason that makedumpfile does not fill in the utsname structure
in the compressed dumpfile's header?  

The data structure does get read into a local new_utsname structure in the
check_release() function, but it doesn't get saved and copied into the
disk_dump_header in write_kdump_header().

It would be helpful if that were in place as a quick ID for what the
compressed dumpfile contains.

Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
