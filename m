Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [162.243.103.125] (helo=houck.info)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bocTK-00084d-8h
 for kexec@lists.infradead.org; Mon, 26 Sep 2016 20:25:54 +0000
Received: from [192.168.1.41] (unknown [71.252.209.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by houck.info (Postfix) with ESMTPSA id 8B7C27F628
 for <kexec@lists.infradead.org>; Mon, 26 Sep 2016 16:19:32 -0400 (EDT)
From: Clif Houck <me@clifhouck.com>
Subject: Limitations/gotchas of kexec?
Message-ID: <fb9324e7-61a9-a22f-b6f4-250336f6092c@clifhouck.com>
Date: Mon, 26 Sep 2016 15:19:50 -0500
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi all,

I was wondering if there's a known list of limitations of kexec?

For example, is there anything fundamentally wrong with trying to kexec
from kernel version X to kernel version Y where:
1) version Y > version X
2) X < Y
3) X == Y

I wouldn't expect to have an issue in case 1 or 3. But maybe if the
distance between two kernel versions is too great then I would have a
problem? Is there any concept of explicit incompatibility between
different kernels coupled with kexec or is it just 'try-and-see'?

Are there other important things to look out for?

Thanks,
Clif Houck	

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
