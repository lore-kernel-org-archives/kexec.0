Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from py-out-1112.google.com ([64.233.166.180])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IadsI-0008OM-FC
	for kexec@lists.infradead.org; Wed, 26 Sep 2007 16:52:53 -0400
Received: by py-out-1112.google.com with SMTP id a25so4982324pyi
	for <kexec@lists.infradead.org>; Wed, 26 Sep 2007 13:52:49 -0700 (PDT)
Date: Wed, 26 Sep 2007 16:52:30 -0400
Subject: Re: [linux-pm] Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Message-ID: <20070926205229.GG31759@nineveh.local>
References: <Pine.LNX.4.44L0.0709211540100.5816-100000@iolanthe.rowland.org>
	<200709221234.18426.rjw@sisk.pl>
	<3BCF760C-D77D-417A-809A-B20D04DD01D3@mac.com>
	<200709222351.32137.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200709222351.32137.rjw@sisk.pl>
From: jfannin@gmail.com (Joseph Fannin)
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>

    FWIW, on all the hardware I have, Windows is able to deal with:

    (1) hibernate Windows
    (2) run $(OTHER_OS)
    (3) resume Windows

... which seems to me to say that Linux is doing it wrong if it can't
handle other ACPI users between hibernate and resume.  But maybe
that's just my hardware.

--
Joseph Fannin
jfannin@gmail.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
