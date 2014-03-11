Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNJ4K-0005ao-Cr
 for kexec@lists.infradead.org; Tue, 11 Mar 2014 09:33:54 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 2/4] build: Use INCLUDES for normal CFLAGS in
 addition to CFLAGS_ARCH
Date: Tue, 11 Mar 2014 09:31:49 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F4CDD@BPXM01GP.gisp.nec.co.jp>
References: <20140307093626.09701790@marrow.netinsight.se>
 <20140307093840.72e71fbe@marrow.netinsight.se>
 <0910DD04CBD6DE4193FCF86B9C00BE971F41D3@BPXM01GP.gisp.nec.co.jp>
 <20140311075730.358bc01f@marrow.netinsight.se>
In-Reply-To: <20140311075730.358bc01f@marrow.netinsight.se>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "simon.kagstrom@netinsight.net" <simon.kagstrom@netinsight.net>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On Mon, 10 Mar 2014 05:26:34 +0000
>Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
>
>> >-CFLAGS = -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
>> >+CFLAGS = $(INCLUDES) -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
>> > 	  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE \
>> > 	  -DVERSION='"$(VERSION)"' -DRELEASE_DATE='"$(DATE)"'
>> > CFLAGS_ARCH	= $(INCLUDES) -g -O2 -Wall -D_FILE_OFFSET_BITS=64 \
>>                   ^^^^^^^^^^^
>> CFLAGS_ARCH also doesn't use INCLUDES in the upstream version,
>> so this diff and the subject of this patch are wrong.
>
>Sorry about that! I merged in the new version, but apparently we had
>some local modifications to the Makefile.
>
>So please drop this patch in the series.

I see, I'll merge the others into v1.5.6.


Thanks
Atsushi Kumagai
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
