Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ia0-x22f.google.com ([2607:f8b0:4001:c02::22f])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TyCD2-0001zD-NX
 for kexec@lists.infradead.org; Thu, 24 Jan 2013 02:06:33 +0000
Received: by mail-ia0-f175.google.com with SMTP id r4so4354083iaj.6
 for <kexec@lists.infradead.org>; Wed, 23 Jan 2013 18:06:29 -0800 (PST)
Message-ID: <51009722.40600@gmail.com>
Date: Wed, 23 Jan 2013 18:06:26 -0800
From: Jay Lan <jay.zen.lan@gmail.com>
MIME-Version: 1.0
Subject: crashkernel reservation failed - No suitable area found
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
Cc: Takashi Iwai <tiwai@suse.de>, xiyou.wangcong@gmail.com, CAI Qian <caiqian@redhat.com>, vgoyal@redhat.com, hpa@zytor.com

Hi,

I searched the web on this subject, and found a discussion thread
on this matter back in March 12, 2012:
     https://lkml.org/lkml/2012/3/13/36
and it seems I hit the same problem on my machine. :-(

We have a system with 4TB memory. When it was shipped, crashkernel
was set to 512M. The crashkernel memory reservation was successful,
but dumping core ran out of memory.  The system runs sles11sp2,
3.0.51-0.7.9.1.

After I tried to raise the reserved memory to 896M, the system started
to fail reserving the requested memory, even after I set it back to 512M:
     crashkernel reservation failed - No suitable area found

Is there a kernel/kexec-tools patch to address this problem in kernel 3.x
yet? Also, according to Takashi Iwa wrote, "the problem does not happen
always. However, once this happens, it continues to happen" :-(
Yes, yes, it drove me completely crazy trying to figure out how to get the
system out of this trapped state! Please help!

Thanks for any help!

Jay



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
