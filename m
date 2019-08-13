Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxV1w-0005Xr-Pq
 for kexec@lists.infradead.org; Tue, 13 Aug 2019 11:31:58 +0000
Subject: Re: [PATCH] do not clean dummy variable in kexec path
From: Laszlo Ersek <lersek@redhat.com>
References: <20190805083553.GA27708@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu-my6EpLfxBnbMn21be62oHrF6PKFu2rt-4Pqk9wG9SXA@mail.gmail.com>
 <fbea659c-6e8f-b854-66d2-2c928d1d3783@redhat.com>
Message-ID: <6209b30e-e3c6-fd7f-4fe6-b6bed72ff041@redhat.com>
Date: Tue, 13 Aug 2019 13:31:51 +0200
MIME-Version: 1.0
In-Reply-To: <fbea659c-6e8f-b854-66d2-2c928d1d3783@redhat.com>
Content-Language: en-US
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Dave Young <dyoung@redhat.com>, Matthew Garrett <mjg59@google.com>
Cc: kexec devel list <kexec@lists.infradead.org>

On 08/13/19 13:28, Laszlo Ersek wrote:
> On 08/05/19 17:55, ard.biesheuvel at linaro.org (Ard Biesheuvel) wrote:

>> I would argue that this means it is not a good place to *create* the
>> dummy variable, and if we don't create it, we don't have to delete it
>> either.

> - Consider moving the cleanup even for cold boot to a different spot.
>   I'd argue for efi_query_variable_store() -- we should delete the dummy
>   variable there, *regardless* of whether we just created it, or it had
>   existed previously.

To clarify: I suggest deleting the dummy -- regardless of it
pre-existing, vs. us creating it on the spot -- *wherever* we create it
during cold boot.

I'm not arguing for efi_query_variable_store() per se. If there is a
better init / setup function, we should move both the creation and the
(independent!) removal there.

Thanks
Laszlo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
