Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZShP5-0003Kn-VS
 for kexec@lists.infradead.org; Fri, 21 Aug 2015 08:10:24 +0000
Received: by wijp15 with SMTP id p15so12814179wij.0
 for <kexec@lists.infradead.org>; Fri, 21 Aug 2015 01:10:00 -0700 (PDT)
Subject: Re: Dmesg not being dumped
References: <mailman.5.1440010802.20553.kexec@lists.infradead.org>
 <2097586247.19732970.1440016713516.JavaMail.zimbra@redhat.com>
 <55D57913.2070303@kyup.com>
 <1497907178.20184517.1440075877293.JavaMail.zimbra@redhat.com>
From: Nikolay Borisov <kernel@kyup.com>
Message-ID: <55D6DCD6.8050000@kyup.com>
Date: Fri, 21 Aug 2015 11:09:58 +0300
MIME-Version: 1.0
In-Reply-To: <1497907178.20184517.1440075877293.JavaMail.zimbra@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org



On 08/20/2015 04:04 PM, Dave Anderson wrote:
> The vmcoreinfo data strings were initially located in an ELF note in /proc/vmcore.
> When makedumpfile -c was run on /proc/vmcore, it copied those ELF notes into the
> compressed kdump header, and you have dumped them above.
> 
> So it seems to be an issue with vmcore-dmesg.  If you change the core_collector
> variable to "cp" or "scp", it will copy /proc/vmcore unmodified to the target
> location.  Then you can run vmcore-dmesg on that file to debug it.

This is very, very odd. Obtaining a raw vmcore with cp and then running
vmcore-dmesg does show the dmesg log. But at the same time, the
vmcore-dmesg.txt file is empty and its name is
vmcore-dmesg-incomplete.txt...

> 
> Dave
>  
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
