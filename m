Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gGOTl-0002tx-VV
 for kexec@lists.infradead.org; Sat, 27 Oct 2018 13:18:16 +0000
Date: Sat, 27 Oct 2018 14:17:58 +0100
In-Reply-To: <20181027110858.GB14493@MiWiFi-R3L-srv>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
 <20181026222517.GB26927@nazgul.tnic> <20181027081343.GA1884@MiWiFi-R3L-srv>
 <20181027091007.GB1046@nazgul.tnic> <20181027093917.GA14493@MiWiFi-R3L-srv>
 <20181027101221.GC1046@nazgul.tnic> <20181027110858.GB14493@MiWiFi-R3L-srv>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
From: Boris Petkov <bp@alien8.de>
Message-ID: <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
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
To: Baoquan He <bhe@redhat.com>
Cc: lijiang <lijiang@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com

On October 27, 2018 12:08:58 PM GMT+01:00, Baoquan He <bhe@redhat.com> wrote:
>OK, then it's fine to get the bit number, e.g calling
>find_first_bit(sme_me_mask, BITS_PER_LONG), and export it to
>vmcoreinfo. Thanks.

You can simply assign sme_me_mask for now...

-- 
Sent from a small device: formatting sux and brevity is inevitable. 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
