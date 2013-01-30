Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-x233.google.com ([2607:f8b0:4001:c03::233])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0fIu-0006tn-6D
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 21:34:48 +0000
Received: by mail-ie0-f179.google.com with SMTP id k11so511918iea.24
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2013 13:34:46 -0800 (PST)
Message-ID: <510991F4.5070400@gmail.com>
Date: Wed, 30 Jan 2013 13:34:44 -0800
From: Jay Lan <jay.zen.lan@gmail.com>
MIME-Version: 1.0
Subject: how to set on debug of kdump initrd?
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

My kdump initrd failed in mounting root disk.
The system runs sles11sp2 and
kexec-tools-2.0.0-53.43.10.

I saw the scripts executed in initrd contain debug like this:

[ "$debug" ] && echo ....

How do I turn on the debug switch when creating the kdump
initrd?

Thanks,
Jay



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
