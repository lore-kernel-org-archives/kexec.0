Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-x241.google.com ([2a00:1450:4010:c04::241])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMJp4-0001nz-I0
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 18:19:07 +0000
Received: by mail-lb0-x241.google.com with SMTP id ad5so1888421lbc.3
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 10:18:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453382376.9549.138.camel@linux.vnet.ibm.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-2-git-send-email-zohar@linux.vnet.ibm.com>
 <CACE9dm_3=CNe-PwWaLk1JCNrFjwJLkxuV13x_jdgPu7wQTKs7w@mail.gmail.com>
 <1453382376.9549.138.camel@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 20:18:44 +0200
Message-ID: <CACE9dm_C2nzYkL8RudvTq-Sdfqcurk9q1_zpWYZ4EDh-7-L2Pw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/11] ima: separate 'security.ima' reading
 functionality from collect
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Kasatkin <d.kasatkin@samsung.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, Jan 21, 2016 at 3:19 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2016-01-19 at 22:00 +0200, Dmitry Kasatkin wrote:
>> Hi Mimi,
>>
>> Please change
>>
>> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
>
> I'll make the change here and in the other patches as well.
>
> Mimi
>

Thanks.

-- 
Thanks,
Dmitry

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
