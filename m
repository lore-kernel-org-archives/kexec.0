Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1489765628.17202.59.camel@infradead.org>
Subject: Re: [PATCH v33 00/14] add kdump support
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20170317153358.GI5940@leverpostej>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <1489750991.17202.40.camel@infradead.org>
 <1489759373.17202.44.camel@infradead.org>
 <20170317153358.GI5940@leverpostej>
Date: Fri, 17 Mar 2017 15:47:08 +0000
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4325035378591028347=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: geoff@infradead.org, kexec@lists.infradead.org, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, catalin.marinas@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org


--===============4325035378591028347==
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/x-pkcs7-signature"; boundary="=-sPG3Uiwn5JX4eRToLjpr"


--=-sPG3Uiwn5JX4eRToLjpr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2017-03-17 at 15:33 +0000, Mark Rutland wrote:
>=20
> We can certainly log a better message, e.g.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool kdump =3D (image =3D=
=3D kexec_crash_image);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool stuck_cpus =3D cpus_=
are_stuck_in_kernel() ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 num_online_cpus() > 1;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BUG_ON(stuck_cpus && !kdu=
mp);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WARN(stuck_cpus, "Unable =
to offline CPUs, kdump will be unreliable.\n");

No, in this case the CPUs *were* offlined correctly, or at least "as
designed", by smp_send_crash_stop(). And if that hadn't worked, as
verified by *its* synchronisation method based on the atomic_t
waiting_for_crash_ipi, then *it* would have complained for itself:

	if (atomic_read(&waiting_for_crash_ipi) > 0)
		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
			=C2=A0=C2=A0=C2=A0cpumask_pr_args(cpu_online_mask));

It's just that smp_send_crash_stop() (or more specifically
ipi_cpu_crash_stop()) doesn't touch the online cpu mask. Unlike the
ARM32 equivalent function machien_crash_nonpanic_core(), which does.

It wasn't clear if that was *intentional*, to allow the original
contents of the online mask before the crash to be seen in the
resulting vmcore... or purely an accident.=C2=A0

FWIW if I trigger a crash on CPU 1 my kdump (still 4.9.8+v32) doesn't work.
I end up booting the kdump kernel on CPU#1 and then it gets distinctly unha=
ppy...

[=C2=A0=C2=A0=C2=A0=C2=A00.000000] Booting Linux on physical CPU 0x1
...
[=C2=A0=C2=A0=C2=A0=C2=A00.017125] Detected PIPT I-cache on CPU1
[=C2=A0=C2=A0=C2=A0=C2=A00.017138] GICv3: CPU1: found redistributor 0 regio=
n 0:0x00000000f0280000
[=C2=A0=C2=A0=C2=A0=C2=A00.017147] CPU1: Booted secondary processor [411fd0=
73]
[=C2=A0=C2=A0=C2=A0=C2=A00.017339] Detected PIPT I-cache on CPU2
[=C2=A0=C2=A0=C2=A0=C2=A00.017347] GICv3: CPU2: found redistributor 2 regio=
n 0:0x00000000f02c0000
[=C2=A0=C2=A0=C2=A0=C2=A00.017354] CPU2: Booted secondary processor [411fd0=
73]
[=C2=A0=C2=A0=C2=A0=C2=A00.017537] Detected PIPT I-cache on CPU3
[=C2=A0=C2=A0=C2=A0=C2=A00.017545] GICv3: CPU3: found redistributor 3 regio=
n 0:0x00000000f02e0000
[=C2=A0=C2=A0=C2=A0=C2=A00.017551] CPU3: Booted secondary processor [411fd0=
73]
[=C2=A0=C2=A0=C2=A0=C2=A00.017576] Brought up 4 CPUs
[=C2=A0=C2=A0=C2=A0=C2=A00.017587] SMP: Total of 4 processors activated.
...
[=C2=A0=C2=A0=C2=A031.745809] INFO: rcu_sched detected stalls on CPUs/tasks=
:
[=C2=A0=C2=A0=C2=A031.751299]=C2=A0	1-...: (30 GPs behind) idle=3Dc90/0/0 s=
oftirq=3D0/0 fqs=3D0=C2=A0
[=C2=A0=C2=A0=C2=A031.757557]=C2=A0	2-...: (30 GPs behind) idle=3D608/0/0 s=
oftirq=3D0/0 fqs=3D0=C2=A0
[=C2=A0=C2=A0=C2=A031.763814]=C2=A0	3-...: (30 GPs behind) idle=3D604/0/0 s=
oftirq=3D0/0 fqs=3D0=C2=A0
[=C2=A0=C2=A0=C2=A031.770069]=C2=A0	(detected by 0, t=3D5252 jiffies, g=3D-=
270, c=3D-271, q=3D0)
[=C2=A0=C2=A0=C2=A031.776161] Task dump for CPU 1:
[=C2=A0=C2=A0=C2=A031.779381] swapper/1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0R=C2=A0=C2=A0running task=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=
 0x00000080
[=C2=A0=C2=A0=C2=A031.786446] Task dump for CPU 2:
[=C2=A0=C2=A0=C2=A031.789666] swapper/2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0R=C2=A0=C2=A0running task=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=
 0x00000080
[=C2=A0=C2=A0=C2=A031.796725] Task dump for CPU 3:
[=C2=A0=C2=A0=C2=A031.799945] swapper/3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0R=C2=A0=C2=A0running task=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=
 0x00000080

Is some of that platform-specific?

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 701c085..41d238e 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -129,7 +129,7 @@ static struct sysrq_key_op sysrq_unraw_op =3D {
=C2=A0#define sysrq_unraw_op (*(struct sysrq_key_op *)NULL)
=C2=A0#endif /* CONFIG_VT */
=C2=A0
-static void sysrq_handle_crash(int key)
+static void do_sysrq_handle_crash(int key)
=C2=A0{
=C2=A0	char *killer =3D NULL;
=C2=A0
@@ -143,6 +143,12 @@ static void sysrq_handle_crash(int key)
=C2=A0	wmb();
=C2=A0	*killer =3D 1;
=C2=A0}
+
+static void sysrq_handle_crash(int key)
+{
+	smp_call_on_cpu(1, (void *)do_sysrq_handle_crash, 0, 1);
+}
+
=C2=A0static struct sysrq_key_op sysrq_crash_op =3D {
=C2=A0	.handler	=3D sysrq_handle_crash,
=C2=A0	.help_msg	=3D "crash(c)",

--=-sPG3Uiwn5JX4eRToLjpr
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDzUw
ggSvMIIDl6ADAgECAhEA4CPLFRKDU4mtYW56VGdrITANBgkqhkiG9w0BAQsFADBvMQswCQYDVQQG
EwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRU
UCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTE0MTIyMjAw
MDAwMFoXDTIwMDUzMDEwNDgzOFowgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEw
PwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAImxDdp6UxlOcFIdvFamBia3
uEngludRq/HwWhNJFaO0jBtgvHpRQqd5jKQi3xdhTpHVdiMKFNNKAn+2HQmAbqUEPdm6uxb+oYep
LkNSQxZ8rzJQyKZPWukI2M+TJZx7iOgwZOak+FaA/SokFDMXmaxE5WmLo0YGS8Iz1OlAnwawsayT
QLm1CJM6nCpToxDbPSBhPFUDjtlOdiUCISn6o3xxdk/u4V+B6ftUgNvDezVSt4TeIj0sMC0xf1m9
UjewM2ktQ+v61qXxl3dnUYzZ7ifrvKUHOHaMpKk4/9+M9QOsSb7K93OZOg8yq5yVOhM9DkY6V3Rh
UL7GQD/L5OKfoiECAwEAAaOCARcwggETMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1Qa
MB0GA1UdDgQWBBSSYWuC4aKgqk/sZ/HCo/e0gADB7DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/
BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRV
HSAAMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4
dGVybmFsQ0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3Nw
LnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQELBQADggEBABsqbqxVwTqriMXY7c1V86prYSvACRAj
mQ/FZmpvsfW0tXdeDwJhAN99Bf4Ss6SAgAD8+x1banICCkG8BbrBWNUmwurVTYT7/oKYz1gb4yJj
nFL4uwU2q31Ypd6rO2Pl2tVz7+zg+3vio//wQiOcyraNTT7kSxgDsqgt1Ni7QkuQaYUQ26Y3NOh7
4AEQpZzKOsefT4g0bopl0BqKu6ncyso20fT8wmQpNa/WsadxEdIDQ7GPPprsnjJT9HaSyoY0B7ks
yuYcStiZDcGG4pCS+1pCaiMhEOllx/XVu37qjIUgAmLq0ToHLFnFmTPyOInltukWeh95FPZKEBom
+nyK+5swggU9MIIEJaADAgECAhBqC1BYlVMtBFBN4igR/howMA0GCSqGSIb3DQEBCwUAMIGbMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3Jk
MRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xp
ZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTYxMjIwMDAwMDAwWhcN
MTcxMjIwMjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwbTrFaiGdvN2pThnR9q+4eaXB2wQZQNqhter5ZrJ
pPO47e87bZ+f1tmYoh6+rB90G/XN24NErPRfvU4zVzNT9pCtCzSSVnBlZQBpaEYMKhcXo5PGKNsm
An8BoGwNXjlxwbBNRaNO+ky0wNCaMNd1JLxEuvqg9J7rrcpHhWmnpXD5IKa8gv9GyVAJgOpiBOts
p91sShc2kHvWJ5waPEWPCHDH9J+twGGKqKIIU7fdbURLUgUL1wlDSAHf/lgIAVCSj2H2HpoGqHpy
HgOAClX9iRSLNa0Znj8HTaqfOwxXevsz1KkLFY+Ahm426GIEqdfkK2iT6Hhgc7tjNO3f8i5ALQID
AQABo4IB8TCCAe0wHwYDVR0jBBgwFoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFILE
dmHLtK6oxmFJZvBhTQhvqrS0MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZ
MBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMw
gYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZyYWRlYWQub3JnMA0GCSqGSIb3
DQEBCwUAA4IBAQA+AfvNhFwtapF5Lzjapgul3zYuEnMfR538Ya1vhP8wuOkcoJeT2gEFXzVO2WUu
eWM0g0/DumnRB53htV/Qq/+vsL0i6a2+iOO7kHi5O7bZkgbdNv0t2lzonDUHi6LTa7NUj+tv+j6y
hW+iNquC3ACP1dIZH8gJmicHblW63qRgp6wxhn315MLBeavi3uiSag2eeKFePiTIwJjN2UYq6kWg
PL5G/Ycf9x/xN1XBTfJiURc0FsXhrA98VMWnt52C5Lo4txhGjzTI+IZg40b3YDs6E7mTYb5KKmbc
QZA9priOFDdj1z5W9BdWhU6I/D0P9y8Z4Tr6+ZscMUVD0RqWy2LeMIIFPTCCBCWgAwIBAgIQagtQ
WJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQsFADCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdy
ZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBMB4XDTE2MTIyMDAwMDAwMFoXDTE3MTIyMDIzNTk1OVowJDEiMCAGCSqG
SIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAMG06xWohnbzdqU4Z0favuHmlwdsEGUDaobXq+WayaTzuO3vO22fn9bZmKIevqwfdBv1zduD
RKz0X71OM1czU/aQrQs0klZwZWUAaWhGDCoXF6OTxijbJgJ/AaBsDV45ccGwTUWjTvpMtMDQmjDX
dSS8RLr6oPSe663KR4Vpp6Vw+SCmvIL/RslQCYDqYgTrbKfdbEoXNpB71iecGjxFjwhwx/SfrcBh
iqiiCFO33W1ES1IFC9cJQ0gB3/5YCAFQko9h9h6aBqh6ch4DgApV/YkUizWtGZ4/B02qnzsMV3r7
M9SpCxWPgIZuNuhiBKnX5Ctok+h4YHO7YzTt3/IuQC0CAwEAAaOCAfEwggHtMB8GA1UdIwQYMBaA
FJJha4LhoqCqT+xn8cKj97SAAMHsMB0GA1UdDgQWBBSCxHZhy7SuqMZhSWbwYU0Ib6q0tDAOBgNV
HQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcDBAYLKwYBBAGyMQED
BQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQECAQEBMCswKQYIKwYB
BQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMF0GA1UdHwRWMFQwUqBQoE6GTGh0
dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcmwwgZAGCCsGAQUFBwEBBIGDMIGAMFgGCCsGAQUFBzAChkxodHRwOi8v
Y3J0LmNvbW9kb2NhLmNvbS9DT01PRE9TSEEyNTZDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0R
BBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAPgH7zYRcLWqReS84
2qYLpd82LhJzH0ed/GGtb4T/MLjpHKCXk9oBBV81TtllLnljNINPw7pp0Qed4bVf0Kv/r7C9Iumt
vojju5B4uTu22ZIG3Tb9Ldpc6Jw1B4ui02uzVI/rb/o+soVvojargtwAj9XSGR/ICZonB25Vut6k
YKesMYZ99eTCwXmr4t7okmoNnnihXj4kyMCYzdlGKupFoDy+Rv2HH/cf8TdVwU3yYlEXNBbF4awP
fFTFp7edguS6OLcYRo80yPiGYONG92A7OhO5k2G+Sipm3EGQPaa4jhQ3Y9c+VvQXVoVOiPw9D/cv
GeE6+vmbHDFFQ9Ealsti3jGCA9MwggPPAgEBMIGwMIGbMQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0Eg
TGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFu
ZCBTZWN1cmUgRW1haWwgQ0ECEGoLUFiVUy0EUE3iKBH+GjAwDQYJYIZIAWUDBAIBBQCgggHzMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDMxNzE1NDcwOFowLwYJ
KoZIhvcNAQkEMSIEIO7ktbMmxrOapbjlSmOSuf8gPE+UnR9fbstVZocXwUaZMIHBBgkrBgEEAYI3
EAQxgbMwgbAwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01P
RE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQ
WJVTLQRQTeIoEf4aMDCBwwYLKoZIhvcNAQkQAgsxgbOggbAwgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQWJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQEFAASC
AQChAe9jNlniFWDWF6kQUYPxUWcZFqN5aeYfnjB6eTz0JVdoJQiw5pspws5QEOO2UTZcsmmUTLQk
Qr2QAqtUPC/orlPyY91ISYiy8QQJhFDYz3bfdKIxoNcJz7xWoKXjQq67I6TRi0h7vgH26TivDX0E
z5pbqlCdzNsIOrhJUX2gKkkRVVCNW0VxdlJh719UmMOxT/ptDdC3NMMFGUtWth29rQpNEwLj6uIS
3HGgh04K5QU2qrptuvhwtTsb1LwqVwq69FrXhemZmbZm+tkBTzaoI64BRyjFS9Gf2eAve+xO0+hh
PkNXRz8KfLq5HGUUdPtWb7skYkVwYBDgO2AofB7pAAAAAAAA


--=-sPG3Uiwn5JX4eRToLjpr--



--===============4325035378591028347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============4325035378591028347==--


