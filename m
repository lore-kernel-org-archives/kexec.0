Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NYV6K-0007D0-0S
	for kexec@lists.infradead.org; Sat, 23 Jan 2010 01:47:52 +0000
Subject: Re: bzip2-compressed bzimage support?
References: <cone.1263962411.847498.22847.1000@toolshiner.phx1.kidfixit.com>
	<201001201014.56630.florian@openwrt.org>
	<cone.1264002495.970050.22847.1000@toolshiner.phx1.kidfixit.com>
	<cone.1264003210.167206.22847.1000@toolshiner.phx1.kidfixit.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 22 Jan 2010 17:47:43 -0800
In-Reply-To: <cone.1264003210.167206.22847.1000@toolshiner.phx1.kidfixit.com>
	(Joey Korkames's message of "Wed\, 20 Jan 2010 09\:00\:10 -0700")
Message-ID: <m13a1x618g.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
To: Joey Korkames <joey+lists@kidfixit.com>
Cc: kexec@lists.infradead.org

Joey Korkames <joey+lists@kidfixit.com> writes:


> Now, if it doesn't matter how the bzImage is compressed, then what are the
> recent lzma commits to kexec-tools.git for?

For arches other than x86 where the tradition is to put the decompressor
in the bootloader, instead of making the kernel a self extracting executable.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
