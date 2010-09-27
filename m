Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P0MXS-0000ja-1r
	for kexec@lists.infradead.org; Mon, 27 Sep 2010 22:51:14 +0000
Message-ID: <4CA11FB7.2080101@zytor.com>
Date: Mon, 27 Sep 2010 15:50:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: kexec load failure introduced by "x86,
	memblock: Replace e820_/_early string with memblock_"
References: <632974489.2046131285586512527.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<4CA11918.7050708@kernel.org>
In-Reply-To: <4CA11918.7050708@kernel.org>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, kexec <kexec@lists.infradead.org>, caiqian@redhat.com, linux-kernel@vger.kernel.org

+		crash_base = alignment;
+		while ((crash_base + crash_size) <= total_mem) {
+			start = memblock_find_in_range(crash_base,
+				crash_base + crash_size, crash_size, alignment);
+
+			if (start == crash_base)
+				break;
+
+			crash_base += alignment;
+		}
+		if (start != crash_base) {

Open-coded crap violation error!

Seriously, these kinds of open-coded loops are *never* acceptable, since
they are really "let's violate the interface by making it do something
it wasn't intended to do" -- it means we need a new interface.

Alternatively, if we really need the lowest possible address, why do we
need to search?

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
