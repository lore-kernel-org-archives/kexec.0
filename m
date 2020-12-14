Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kosyS-0000Ub-NS
 for kexec@lists.infradead.org; Mon, 14 Dec 2020 18:53:33 +0000
Received: from mail-ej1-f72.google.com ([209.85.218.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kosyR-0001BY-Ax
 for kexec@lists.infradead.org; Mon, 14 Dec 2020 18:53:31 +0000
Received: by mail-ej1-f72.google.com with SMTP id dv25so4871061ejb.15
 for <kexec@lists.infradead.org>; Mon, 14 Dec 2020 10:53:31 -0800 (PST)
MIME-Version: 1.0
References: <87h7oudcbx.fsf@vps.thesusis.net>
In-Reply-To: <87h7oudcbx.fsf@vps.thesusis.net>
From: "Guilherme G. Piccoli" <guilherme.piccoli@canonical.com>
Date: Mon, 14 Dec 2020 15:52:55 -0300
Message-ID: <CAHD1Q_zcruQ6KVHApvhb=0+mG0m80T+tmg1UzjQBki8j+aR51A@mail.gmail.com>
Subject: Re: kexec not working in xen domU?
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
To: Phillip Susi <phill@thesusis.net>
Cc: xen-devel@lists.xenproject.org, kexec mailing list <kexec@lists.infradead.org>

On Wed, Dec 9, 2020 at 4:13 PM Phillip Susi <phill@thesusis.net> wrote:
>
> Whenever I try to use kexec in a xen domU, the domain just reboots all
> the way through the bios rather than loading the kexec'ed kernel with
> the given command line.  Is this a known issue?  I've tried with both
> systemctl kexec and kexec -e.
>

Can you capture the serial console in a pastebin? Maybe add something
like "earlyprintk=ttySX", where ttySX is your known-to-work serial
console output. This helps to determine if it's a shutdown issue or an
early boot problem.
Also, worth to CC Xen mailing-list in this discussion I guess, I'm CCing them.
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
