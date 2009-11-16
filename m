Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NA3Ny-0001E8-7U
	for kexec@lists.infradead.org; Mon, 16 Nov 2009 15:21:03 +0000
Received: by yxe40 with SMTP id 40so5140068yxe.28
	for <kexec@lists.infradead.org>; Mon, 16 Nov 2009 07:20:56 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 16 Nov 2009 23:20:54 +0800
Message-ID: <e997b7420911160720m278751c2m9ddb49f4ee4aa334@mail.gmail.com>
Subject: smp support in kexec
From: "wilbur.chan" <wilbur512@gmail.com>
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
To: kexec@lists.infradead.org

Hi all!

Recently , I am trying    kexec smp feature support for ppc64,  and mips64 .

I found that , ppc64  makes  the secondary cpus to spin in a loop
,while in mips64 , the seconday cpus wait until the main cpu  jumped
to kernel entry , and then they(secondary cpus)

jumped to kernel entry too .



So I 've got some questions on the entry point for cpus.

It seemed that , in kernel code , seconday cpus were brought up by
main cpu in a 'init' process .

After initializing , the main cpu send ipi to all  secondary cpus
,waked them up , and  then , secondary cpus jump to a different
'secondary ' entry point. But patches show that ,all cpus

will jumped to the same entry ,so I 'm not sure about this , if all
cpus would have the simillar  boot process  or not.



Any suggestion?

Thank you


regards,

wilbur

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
