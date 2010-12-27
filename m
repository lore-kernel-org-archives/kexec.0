Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PXJjV-0000l1-Rw
	for kexec@lists.infradead.org; Mon, 27 Dec 2010 20:31:54 +0000
Message-ID: <4D18F798.4010708@zytor.com>
Date: Mon, 27 Dec 2010 12:31:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: How does kdump deal with trampoline allocation?
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>, Yinghai Lu <yinghai@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>

Hi guys,

I'm planning a major overhaul of the trampoline allocation in x86, and
I'm trying to understand how kdump deals with it.  The trampoline has to
be allocated in low memory (< 1 MiB) and obviously that doesn't include
the kdump area at all.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
