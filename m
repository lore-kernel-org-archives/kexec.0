Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx40.brocade.com ([144.49.195.4])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LRwK8-00051Y-MG
	for kexec@lists.infradead.org; Tue, 27 Jan 2009 22:22:27 +0000
Received: from HQ-EXCHFE-3.corp.brocade.com (hq-exchfe-3-smtp.brocade.com
	[192.168.126.212])
	by discus.brocade.com (Postfix) with ESMTP id 7C17A2382FD
	for <kexec@lists.infradead.org>; Tue, 27 Jan 2009 14:22:19 -0800 (PST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: should kernel image destination address be picked up by kernel itself?
Date: Tue, 27 Jan 2009 14:22:18 -0800
Message-ID: <4C94DE2070B172459E4F1EE14BD2364E027534BA@HQ-EXCH-5.corp.brocade.com>
From: "Ming Lei" <mlei@Brocade.COM>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


As I understand the code, current destination address is picked up by
either the user(elf image) or kexec-tools. It is not automatic, can we
let linux kernel choose the address instead? It is automatic and no way
to wipe out something important.

Thanks
Ming


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
