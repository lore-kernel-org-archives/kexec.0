Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from alln-iport-2.cisco.com ([173.37.142.89])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMj25-0008DK-Ax
 for kexec@lists.infradead.org; Mon, 11 Jul 2016 21:46:29 +0000
From: Daniel Walker <danielwa@cisco.com>
Subject: IO memory read from /proc/vmcore leads to hang.
Message-ID: <57841399.1030703@cisco.com>
Date: Mon, 11 Jul 2016 14:46:01 -0700
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>


Hi,

I found found that on my Powerpc machine there is some IO memory which 
will cause the box to hang if I read it. It's a custom device that was 
added to the board for a special purpose.

I was looking for a way to exclude this memory from the dump, and while 
doing that I found that kexec makes a list of memory segments that go 
into the core file. I was wondering why most of the kexec architecture 
don't appear to exclude device memory like what's listed in /proc/iomem.

Is there a good reason why that's not the case?

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
