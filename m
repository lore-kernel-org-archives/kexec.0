Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1Hfh-0000zz-UB
 for kexec@lists.infradead.org; Thu, 09 Jan 2014 15:37:26 +0000
Date: Thu, 9 Jan 2014 10:37:03 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Query regarding ELF loader arg style
Message-ID: <20140109153703.GE25897@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Hi Eric,

I am looking at kexec ELF loader code and wondering what are arg style
options.

#define ARG_STYLE_ELF   0
#define ARG_STYLE_LINUX 1
#define ARG_STYLE_NONE  2


I have looked at them many a times but frankly never fully understood
what do they represent and what's the intention behind them. Can you
please elaborate a bit on this.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
