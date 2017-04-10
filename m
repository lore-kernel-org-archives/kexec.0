Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cxXxB-0005dw-8P
 for kexec@lists.infradead.org; Mon, 10 Apr 2017 11:58:02 +0000
Received: by mail-pf0-f178.google.com with SMTP id o126so32361767pfb.3
 for <kexec@lists.infradead.org>; Mon, 10 Apr 2017 04:57:32 -0700 (PDT)
MIME-Version: 1.0
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 10 Apr 2017 17:27:31 +0530
Message-ID: <CACi5LpNCJ-h=v31itkhAkZiXYYuAG-7jMz7g6jBuhgZtpPMhyQ@mail.gmail.com>
Subject: No man page for kdump (yet?)
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
To: kexec@lists.infradead.org, ebiederm@xmission.com, horms@verge.net.au

Hi,

It seems the latest upstream kexec-tools does support a complete man
page for kdump yet:

DESCRIPTION
       kdump does not have a man page yet.

I would propose having a propose having a man page for kdump (as the
feature is quite useful and has matured over time).

I can work to cook up a patch for the same.

Please let me know if this makes sense or if there are any objections
to the same.

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
