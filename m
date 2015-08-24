Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZTrPr-0005lk-Ih
 for kexec@lists.infradead.org; Mon, 24 Aug 2015 13:04:00 +0000
Date: Mon, 24 Aug 2015 09:03:32 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <435200626.24541654.1440421412725.JavaMail.zimbra@redhat.com>
In-Reply-To: <55D6DCD6.8050000@kyup.com>
References: <mailman.5.1440010802.20553.kexec@lists.infradead.org>
 <2097586247.19732970.1440016713516.JavaMail.zimbra@redhat.com>
 <55D57913.2070303@kyup.com>
 <1497907178.20184517.1440075877293.JavaMail.zimbra@redhat.com>
 <55D6DCD6.8050000@kyup.com>
Subject: Re: Dmesg not being dumped
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
To: Nikolay Borisov <kernel@kyup.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> 
> 
> On 08/20/2015 04:04 PM, Dave Anderson wrote:
> > The vmcoreinfo data strings were initially located in an ELF note in /proc/vmcore.
> > When makedumpfile -c was run on /proc/vmcore, it copied those ELF notes into the
> > compressed kdump header, and you have dumped them above.
> > 
> > So it seems to be an issue with vmcore-dmesg.  If you change the core_collector
> > variable to "cp" or "scp", it will copy /proc/vmcore unmodified to the target
> > location.  Then you can run vmcore-dmesg on that file to debug it.
> 
> This is very, very odd. Obtaining a raw vmcore with cp and then running
> vmcore-dmesg does show the dmesg log. But at the same time, the
> vmcore-dmesg.txt file is empty and its name is
> vmcore-dmesg-incomplete.txt...

I'm not sure what you mean.  Similar to the saving of the vmcore file, the
script directs the output of vmcore-dmesg into vmcore-dmesg-incomplete.txt.
Then, only if vmcore-dmesg returns an exit status of 0, the script will 
rename the file to vmcore-dmesg.txt.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
